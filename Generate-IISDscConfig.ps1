# Generate DSC configuration based on exported IIS configuration
function Generate-IISDscConfiguration {
    [CmdletBinding()]
    param (
        [string]$OutputPath = ".",
        [string]$AppPoolsJsonPath,
        [string]$WebsitesJsonPath,
        [string]$ApplicationsJsonPath,
        [string]$VDirsJsonPath
    )

    # If input file paths are not specified, use default paths
    if (-not $AppPoolsJsonPath) {
        $AppPoolsJsonPath = "$OutputPath\iis-apppools.json"
    }
    if (-not $WebsitesJsonPath) {
        $WebsitesJsonPath = "$OutputPath\iis-websites.json"
    }
    if (-not $ApplicationsJsonPath) {
        $ApplicationsJsonPath = "$OutputPath\iis-applications.json"
    }
    if (-not $VDirsJsonPath) {
        $VDirsJsonPath = "$OutputPath\iis-vdirs.json"
    }

    # Check if required files exist
    $filesExist = $true
    if (-not (Test-Path $AppPoolsJsonPath)) {
        Write-Warning "Application pools JSON not found at: $AppPoolsJsonPath"
        $filesExist = $false
    }
    if (-not (Test-Path $WebsitesJsonPath)) {
        Write-Warning "Websites JSON not found at: $WebsitesJsonPath"
        $filesExist = $false
    }
    if (-not (Test-Path $ApplicationsJsonPath)) {
        Write-Warning "Applications JSON not found at: $ApplicationsJsonPath"
        $filesExist = $false
    }
    if (-not (Test-Path $VDirsJsonPath)) {
        Write-Warning "Virtual directories JSON not found at: $VDirsJsonPath"
        $filesExist = $false
    }

    if (-not $filesExist) {
        Write-Warning "One or more required files not found. Run Export-IISConfig.ps1 first."
        return
    }

    # Read the JSON exports
    try {
        $appPools = Get-Content $AppPoolsJsonPath | ConvertFrom-Json
        $websites = Get-Content $WebsitesJsonPath | ConvertFrom-Json
        $applications = Get-Content $ApplicationsJsonPath | ConvertFrom-Json
        $vdirs = Get-Content $VDirsJsonPath | ConvertFrom-Json
    }
    catch {
        Write-Error "Error reading IIS configuration JSON files: $_"
        return
    }

    # Build DSC Configuration
    $dscConfigContent = @"
# Generated DSC Configuration for IIS setup
Configuration IISSetup {
    param (
        [string]`$NodeName = 'localhost'
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName xWebAdministration

    Node `$NodeName {
        # First ensure IIS is installed
        WindowsFeature IIS {
            Ensure = "Present"
            Name   = "Web-Server"
        }

        # Install IIS Management tools
        WindowsFeature IISManagementTools {
            Ensure = "Present"
            Name   = "Web-Mgmt-Tools"
            DependsOn = "[WindowsFeature]IIS"
        }

"@

    # Add Application Pools to DSC Config
    if ($appPools -and $appPools.Count -gt 0) {
        $dscConfigContent += "`n        # Application Pools`n"
        foreach ($pool in $appPools) {
            $poolName = $pool.Name -replace '[\W]', ''  # Remove special chars for resource ID
            $identityType = if ($pool.ProcessModel) { $pool.ProcessModel } else { "ApplicationPoolIdentity" }
            $runtimeVersion = if ($pool.ManagedRuntimeVersion -eq "") { "No Managed Code" } else { $pool.ManagedRuntimeVersion }
            
            $dscConfigContent += @"
        xWebAppPool $poolName {
            Name                  = "$($pool.Name)"
            Ensure                = "Present"
            State                 = "Started"
            autoStart             = `$true
            managedRuntimeVersion = "$runtimeVersion"
            managedPipelineMode   = "$($pool.ManagedPipelineMode)"
            identityType          = "$identityType"
            DependsOn             = "[WindowsFeature]IIS"
        }

"@
        }
    }

    # Add Websites to DSC Config
    if ($websites -and $websites.Count -gt 0) {
        $dscConfigContent += "`n        # Websites`n"
        foreach ($site in $websites) {
            $siteName = $site.Name -replace '[\W]', ''  # Remove special chars for resource ID
            $poolName = $site.ApplicationPool -replace '[\W]', ''  # For depends on reference
            
            # For each website, create physical path if it doesn't exist
            $dscConfigContent += @"
        File ${siteName}Directory {
            Ensure          = "Present"
            Type            = "Directory"
            DestinationPath = "$($site.PhysicalPath)"
        }

"@

            # Create bindings string
            $bindingsArray = @()
            if ($site.Bindings -and $site.Bindings.Count -gt 0) {
                foreach ($binding in $site.Bindings) {
                    # Parse binding information
                    $bindingInfo = $binding.BindingInfo -split ':'
                    if ($bindingInfo.Count -ge 3) {
                        $ip = $bindingInfo[0]
                        $port = $bindingInfo[1]
                        $hostHeader = $bindingInfo[2]
                        
                        # Handle special case for empty IP
                        if ($ip -eq '') { $ip = '*' }
                        
                        $bindingsArray += @{
                            Protocol = $binding.Protocol
                            IPAddress = $ip
                            Port = $port
                            HostHeader = $hostHeader
                        }
                    }
                }
            }
            
            $bindingsString = "@(`n"
            foreach ($b in $bindingsArray) {
                $bindingsString += "                @{Protocol='$($b.Protocol)';IPAddress='$($b.IPAddress)';Port=$($b.Port);HostHeader='$($b.HostHeader)'}`n"
            }
            $bindingsString += "            )"
            
            # Create the website resource
            $dscConfigContent += @"
        xWebsite $siteName {
            Ensure          = "Present"
            Name            = "$($site.Name)"
            State           = "Started"
            PhysicalPath    = "$($site.PhysicalPath)"
            ApplicationPool = "$($site.ApplicationPool)"
            BindingInfo     = $bindingsString
            DependsOn       = @("[File]${siteName}Directory", "[xWebAppPool]$poolName")
        }

"@
        }
    }

    # Add Web Applications to DSC Config
    if ($applications -and $applications.Count -gt 0) {
        $dscConfigContent += "`n        # Web Applications`n"
        foreach ($app in $applications) {
            $appResourceName = ($app.SiteName + $app.Name) -replace '[\W]', ''
            $siteName = $app.SiteName -replace '[\W]', ''
            $poolName = $app.ApplicationPool -replace '[\W]', ''
            
            # Create physical path if needed
            $dscConfigContent += @"
        File ${appResourceName}Directory {
            Ensure          = "Present"
            Type            = "Directory"
            DestinationPath = "$($app.PhysicalPath)"
        }

        xWebApplication $appResourceName {
            Ensure                  = "Present"
            Name                    = "$($app.Name)"
            WebAppPool              = "$($app.ApplicationPool)" 
            Website                 = "$($app.SiteName)"
            PhysicalPath            = "$($app.PhysicalPath)"
            PreloadEnabled          = `$true
            EnabledProtocols        = "http"
            DependsOn               = @("[xWebsite]$siteName", "[xWebAppPool]$poolName", "[File]${appResourceName}Directory")
        }

"@
        }
    }

    # Add Virtual Directories to DSC Config
    if ($vdirs -and $vdirs.Count -gt 0) {
        $dscConfigContent += "`n        # Virtual Directories`n"
        foreach ($vdir in $vdirs) {
            $vdirResourceName = ($vdir.SiteName + $vdir.Name) -replace '[\W]', ''
            $siteName = $vdir.SiteName -replace '[\W]', ''
            
            # Create physical path if needed
            $dscConfigContent += @"
        File ${vdirResourceName}Directory {
            Ensure          = "Present"
            Type            = "Directory"
            DestinationPath = "$($vdir.PhysicalPath)"
        }

        xWebVirtualDirectory $vdirResourceName {
            Ensure       = "Present"
            Name         = "$($vdir.Name)"
            Website      = "$($vdir.SiteName)"
            PhysicalPath = "$($vdir.PhysicalPath)"
            DependsOn    = @("[xWebsite]$siteName", "[File]${vdirResourceName}Directory")
        }

"@
        }
    }

    # Close the configuration
    $dscConfigContent += @"
    }
}

# Uncomment to generate the MOF files for this configuration
# IISSetup -OutputPath .\IIS-DSC
"@

    # Save the DSC configuration to a file
    try {
        $dscConfigContent | Out-File -FilePath "$OutputPath\IIS-DSC-Configuration.ps1" -Encoding utf8 -Force
        Write-Host "DSC configuration saved to $OutputPath\IIS-DSC-Configuration.ps1" -ForegroundColor Green
    }
    catch {
        Write-Error "Failed to save DSC configuration: $_"
    }
}

# Run the function if script is executed directly (not dot-sourced)
if ($MyInvocation.InvocationName -ne '.') {
    Generate-IISDscConfiguration
}