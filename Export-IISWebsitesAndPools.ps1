# Export IIS Websites and Application Pools
[CmdletBinding()]
param(
    [Parameter()]
    [string]$OutputPath = ".",
    
    [Parameter()]
    [switch]$VerboseOutput,
    
    [Parameter()]
    [int]$TimeoutSeconds = 60,
    
    [Parameter()]
    [switch]$SkipProblemSites
)

# Add immediate output to ensure script is running
Write-Host "Script started at $(Get-Date)" -ForegroundColor Magenta
Write-Host "PowerShell Version: $($PSVersionTable.PSVersion)" -ForegroundColor Magenta
Write-Host "PowerShell Edition: $($PSVersionTable.PSEdition)" -ForegroundColor Magenta
Write-Host "Current Directory: $(Get-Location)" -ForegroundColor Magenta

Write-Host "Exporting IIS Websites and Application Pools..." -ForegroundColor Cyan

# Ensure output directory exists
if (-not (Test-Path $OutputPath)) {
    New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
}

# Function to write verbose output
function Write-VerboseMsg {
    param([string]$Message)
    if ($VerboseOutput) {
        Write-Host "[DEBUG] $Message" -ForegroundColor DarkGray
    }
}

# Function to execute with timeout
function Invoke-WithTimeout {
    param (
        [ScriptBlock]$ScriptBlock,
        [int]$Seconds = 30,
        [string]$OperationName = "Operation"
    )
    
    $job = Start-Job -ScriptBlock $ScriptBlock
    
    try {
        $completed = Wait-Job -Job $job -Timeout $Seconds
        if (-not $completed) {
            Write-Warning "$OperationName timed out after $Seconds seconds"
            Stop-Job -Job $job
            return $null
        } else {
            return Receive-Job -Job $job
        }
    } finally {
        Remove-Job -Job $job -Force -ErrorAction SilentlyContinue
    }
}

# Ensure WebAdministration module is loaded - without using SkipEditionCheck parameter
$isPSCore = $PSVersionTable.PSEdition -eq 'Core'
Write-VerboseMsg "PowerShell Edition: $($PSVersionTable.PSEdition)"

try {
    Write-VerboseMsg "Attempting to import WebAdministration module..."
    
    # Use different import methods based on PowerShell version
    if ($isPSCore) {
        # For PowerShell Core, we need a different approach
        Write-Host "Using PowerShell Core - IIS management is limited" -ForegroundColor Yellow
        
        # Only try SkipEditionCheck if PS version supports it (7.0+)
        if ($PSVersionTable.PSVersion.Major -ge 7) {
            try {
                Import-Module WebAdministration -SkipEditionCheck -ErrorAction Stop
                Write-VerboseMsg "WebAdministration module imported with SkipEditionCheck"
            }
            catch {
                Write-Warning "Could not import WebAdministration with SkipEditionCheck: $_"
                # Fallback to standard import
                Import-Module WebAdministration -ErrorAction Stop
            }
        }
        else {
            # Older PowerShell Core versions
            Import-Module WebAdministration -ErrorAction Stop
        }
    } 
    else {
        # Windows PowerShell is simpler
        Import-Module WebAdministration -ErrorAction Stop
    }
    
    Write-VerboseMsg "WebAdministration module imported successfully"
} 
catch {
    Write-Error "Could not load WebAdministration module: $_"
    Write-Host "This is often because IIS or IIS management tools are not installed." -ForegroundColor Yellow
    Write-Host "Try running: Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementScriptingTools" -ForegroundColor Yellow
    
    # Create empty output files so the rest of the export process can continue
    Write-Host "Creating empty output files to allow export process to continue" -ForegroundColor Yellow
    @() | ConvertTo-Json | Out-File -FilePath "$OutputPath\iis-apppools.json" -Encoding UTF8
    @() | ConvertTo-Json | Out-File -FilePath "$OutputPath\iis-websites.json" -Encoding UTF8
    
    # Create simple installation script that will show warnings
    $simpleInstallScript = @"
# IIS Websites and Application Pools Installation Script
Write-Host "IIS information was not exported from the source machine." -ForegroundColor Yellow
Write-Host "This is often because IIS was not installed or the management tools were missing." -ForegroundColor Yellow
Write-Host "To install IIS management tools, run:" -ForegroundColor Yellow
Write-Host "Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementScriptingTools" -ForegroundColor Yellow
"@
    
    $simpleInstallScript | Out-File -FilePath "$OutputPath\Install-IISWebsitesAndPools.ps1" -Encoding UTF8
    
    # Return early as we can't continue
    return
}

# Verify IIS drive exists
if (-not (Test-Path "IIS:\")) {
    Write-Error "IIS:\ drive is not accessible. IIS may not be installed or properly configured."
    
    # Create empty output files and return
    @() | ConvertTo-Json | Out-File -FilePath "$OutputPath\iis-apppools.json" -Encoding UTF8
    @() | ConvertTo-Json | Out-File -FilePath "$OutputPath\iis-websites.json" -Encoding UTF8
    
    $simpleInstallScript = @"
# IIS Websites and Application Pools Installation Script
Write-Host "IIS information was not exported from the source machine." -ForegroundColor Yellow
Write-Host "The IIS:\ drive was not accessible. IIS may not be installed." -ForegroundColor Yellow
Write-Host "To install IIS and management tools, run:" -ForegroundColor Yellow
Write-Host "Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole" -ForegroundColor Yellow
Write-Host "Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementScriptingTools" -ForegroundColor Yellow
"@
    
    $simpleInstallScript | Out-File -FilePath "$OutputPath\Install-IISWebsitesAndPools.ps1" -Encoding UTF8
    
    return
}

# Get app pools (directly, without using jobs)
try {
    Write-Host "Retrieving application pools..." -ForegroundColor Yellow
    Write-VerboseMsg "Getting IIS application pools..."
    
    $appPoolsList = @()
    
    # Use direct method to get application pools
    try {
        $appPoolObjects = Get-ChildItem -Path "IIS:\AppPools" -ErrorAction Stop
        Write-VerboseMsg "Found $($appPoolObjects.Count) application pools"
        
        foreach ($pool in $appPoolObjects) {
            Write-VerboseMsg "Processing app pool: $($pool.Name)"
            
            # Extract basic properties
            $appPoolsList += @{
                Name = $pool.Name
                ManagedRuntimeVersion = $pool.managedRuntimeVersion
                ManagedPipelineMode = $pool.managedPipelineMode
                AutoStart = $pool.autoStart
                StartMode = $pool.startMode
                ProcessModel = @{
                    IdentityType = $pool.processModel.identityType
                    IdleTimeout = $(if ($pool.processModel.idleTimeout) { $pool.processModel.idleTimeout.TotalMinutes } else { 20 })
                    MaxProcesses = $pool.processModel.maxProcesses
                    PingingEnabled = $pool.processModel.pingingEnabled
                    PingInterval = $(if ($pool.processModel.pingInterval) { $pool.processModel.pingInterval.TotalSeconds } else { 30 })
                    PingResponseTime = $(if ($pool.processModel.pingResponseTime) { $pool.processModel.pingResponseTime.TotalSeconds } else { 90 })
                    ShutdownTimeLimit = $(if ($pool.processModel.shutdownTimeLimit) { $pool.processModel.shutdownTimeLimit.TotalSeconds } else { 90 })
                    StartupTimeLimit = $(if ($pool.processModel.startupTimeLimit) { $pool.processModel.startupTimeLimit.TotalSeconds } else { 90 })
                }
            }
        }
    }
    catch {
        Write-Error "Error accessing application pools: $_"
    }
    
    # Save application pools data
    $appPoolsFile = "$OutputPath\iis-apppools.json"
    Write-Host "Saving $($appPoolsList.Count) application pools to $appPoolsFile" -ForegroundColor Yellow
    $appPoolsList | ConvertTo-Json -Depth 10 | Out-File -FilePath $appPoolsFile -Encoding UTF8
    Write-Host "Application pools export completed" -ForegroundColor Green
}
catch {
    Write-Error "Error exporting application pools: $_"
}

# Get websites (directly, without using jobs)
try {
    Write-Host "Retrieving websites..." -ForegroundColor Yellow
    Write-VerboseMsg "Getting IIS websites..."
    
    $websitesList = @()
    
    # Known problematic sites to skip if SkipProblemSites is set
    $problemSites = @("Nmbrs.Api.V3")
    
    # Use direct method to get websites
    try {
        $siteObjects = Get-ChildItem -Path "IIS:\Sites" -ErrorAction Stop
        Write-VerboseMsg "Found $($siteObjects.Count) websites"
        
        foreach ($site in $siteObjects) {
            $siteName = $site.Name
            
            if ($SkipProblemSites -and $problemSites -contains $siteName) {
                Write-Warning "Skipping known problematic site: $siteName (use -SkipProblemSites:$false to process it)"
                continue
            }
            
            Write-VerboseMsg "Processing website: $siteName"
            
            try {
                # Extract basic site properties
                $siteData = @{
                    Name = $siteName
                    ID = $site.ID
                    State = $site.State
                    PhysicalPath = $site.PhysicalPath
                    ApplicationPool = $site.ApplicationPool
                    Bindings = @()
                    Applications = @()
                }
                
                # Process bindings
                if ($site.Bindings -and $site.Bindings.Collection) {
                    foreach ($binding in $site.Bindings.Collection) {
                        $siteData.Bindings += @{
                            Protocol = $binding.protocol
                            BindingInformation = $binding.bindingInformation
                            SslFlags = $(try { $binding.sslFlags } catch { 0 })
                        }
                    }
                }
                
                # Process applications more safely
                $appPaths = @()
                try {
                    $appItems = Get-ChildItem -Path "IIS:\Sites\$siteName" -ErrorAction SilentlyContinue | 
                                Where-Object { $_.NodeType -eq 'application' }
                    
                    foreach ($app in $appItems) {
                        # Add the application path to process
                        $appPaths += $app
                    }
                }
                catch {
                    Write-VerboseMsg "Error getting application list for site $siteName`: $_"
                }
                
                # Process each application
                foreach ($app in $appPaths) {
                    try {
                        $appPath = $app.Path
                        $appPoolName = $app.applicationPool
                        $appPhysicalPath = $app.PhysicalPath
                        
                        $vdirs = @()
                        try {
                            # Try to get virtual directories
                            $vdirItems = Get-WebVirtualDirectory -Site $siteName -Application $appPath -ErrorAction SilentlyContinue
                            
                            foreach ($vdir in $vdirItems) {
                                $vdirs += @{
                                    Path = $vdir.Path
                                    PhysicalPath = $vdir.PhysicalPath
                                }
                            }
                        }
                        catch {}
                        
                        # Add the application to the site data
                        $siteData.Applications += @{
                            Path = $appPath
                            ApplicationPool = $appPoolName
                            PhysicalPath = $appPhysicalPath
                            VirtualDirectories = $vdirs
                        }
                    }
                    catch {
                        Write-VerboseMsg "Error processing application for site $siteName`: $_"
                    }
                }
                
                # Add the site to our list
                $websitesList += $siteData
            }
            catch {
                Write-Error "Error processing website $siteName`: $_"
            }
        }
    }
    catch {
        Write-Error "Error accessing websites: $_"
    }
    
    # Save websites data
    $websitesFile = "$OutputPath\iis-websites.json"
    Write-Host "Saving $($websitesList.Count) websites to $websitesFile" -ForegroundColor Yellow
    $websitesList | ConvertTo-Json -Depth 10 | Out-File -FilePath $websitesFile -Encoding UTF8
    Write-Host "Websites export completed" -ForegroundColor Green
}
catch {
    Write-Error "Error exporting websites: $_"
}

# Create installation script
try {
    Write-Host "Creating installation script..." -ForegroundColor Yellow
    
    $installScript = @"
# IIS Websites and Application Pools Installation Script
[CmdletBinding()]
param(
    [Parameter()]
    [string]`$InputPath = "."
)

Write-Host "Installing IIS Websites and Application Pools..." -ForegroundColor Cyan

# Ensure WebAdministration module is loaded
try {
    Import-Module WebAdministration -ErrorAction Stop
} catch {
    Write-Error "Could not load WebAdministration module. This function requires the module to be installed."
    Write-Error "Run: Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementScriptingTools -NoRestart"
    return
}

# Test if IIS drive is accessible
if (-not (Test-Path "IIS:\")) {
    Write-Error "Cannot access IIS:\ drive. IIS might not be installed or properly configured."
    Write-Error "Run: Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole -NoRestart"
    return
}

# 1. Import Application Pools
Write-Host "Importing Application Pools..." -ForegroundColor Yellow
if (Test-Path "`$InputPath\iis-apppools.json") {
    `$appPoolsJson = Get-Content -Path "`$InputPath\iis-apppools.json" -Raw
    `$appPools = ConvertFrom-Json -InputObject `$appPoolsJson

    foreach (`$pool in `$appPools) {
        `$poolName = `$pool.Name
        
        # Check if app pool exists
        if (Test-Path "IIS:\AppPools\`$poolName") {
            Write-Host "Application Pool '`$poolName' already exists. Skipping..." -ForegroundColor Yellow
            continue
        }
        
        # Create app pool
        Write-Host "Creating Application Pool: `$poolName" -ForegroundColor Green
        New-WebAppPool -Name `$poolName
        
        # Configure app pool
        if (`$pool.ManagedRuntimeVersion -ne `$null) {
            Set-ItemProperty -Path "IIS:\AppPools\`$poolName" -Name managedRuntimeVersion -Value `$pool.ManagedRuntimeVersion
        }
        
        if (`$pool.ManagedPipelineMode -ne `$null) {
            Set-ItemProperty -Path "IIS:\AppPools\`$poolName" -Name managedPipelineMode -Value `$pool.ManagedPipelineMode
        }
        
        if (`$pool.AutoStart -ne `$null) {
            Set-ItemProperty -Path "IIS:\AppPools\`$poolName" -Name autoStart -Value `$pool.AutoStart
        }
        
        if (`$pool.StartMode) {
            Set-ItemProperty -Path "IIS:\AppPools\`$poolName" -Name startMode -Value `$pool.StartMode
        }
        
        # Configure process model
        if (`$pool.ProcessModel) {
            try {
                if (`$pool.ProcessModel.IdentityType) {
                    Set-ItemProperty -Path "IIS:\AppPools\`$poolName" -Name processModel.identityType -Value `$pool.ProcessModel.IdentityType
                }
                
                if (`$pool.ProcessModel.IdleTimeout) {
                    Set-ItemProperty -Path "IIS:\AppPools\`$poolName" -Name processModel.idleTimeout -Value ([TimeSpan]::FromMinutes(`$pool.ProcessModel.IdleTimeout))
                }
                
                if (`$pool.ProcessModel.MaxProcesses) {
                    Set-ItemProperty -Path "IIS:\AppPools\`$poolName" -Name processModel.maxProcesses -Value `$pool.ProcessModel.MaxProcesses
                }
                
                if (`$pool.ProcessModel.PingingEnabled -ne `$null) {
                    Set-ItemProperty -Path "IIS:\AppPools\`$poolName" -Name processModel.pingingEnabled -Value `$pool.ProcessModel.PingingEnabled
                }
                
                if (`$pool.ProcessModel.PingInterval) {
                    Set-ItemProperty -Path "IIS:\AppPools\`$poolName" -Name processModel.pingInterval -Value ([TimeSpan]::FromSeconds(`$pool.ProcessModel.PingInterval))
                }
                
                if (`$pool.ProcessModel.PingResponseTime) {
                    Set-ItemProperty -Path "IIS:\AppPools\`$poolName" -Name processModel.pingResponseTime -Value ([TimeSpan]::FromSeconds(`$pool.ProcessModel.PingResponseTime))
                }
                
                if (`$pool.ProcessModel.ShutdownTimeLimit) {
                    Set-ItemProperty -Path "IIS:\AppPools\`$poolName" -Name processModel.shutdownTimeLimit -Value ([TimeSpan]::FromSeconds(`$pool.ProcessModel.ShutdownTimeLimit))
                }
                
                if (`$pool.ProcessModel.StartupTimeLimit) {
                    Set-ItemProperty -Path "IIS:\AppPools\`$poolName" -Name processModel.startupTimeLimit -Value ([TimeSpan]::FromSeconds(`$pool.ProcessModel.StartupTimeLimit))
                }
            } catch {
                Write-Warning "Error setting process model properties for `$poolName`: `$_"
            }
        }
    }
} else {
    Write-Warning "Application pool file not found: `$InputPath\iis-apppools.json"
}

# 2. Import Websites
Write-Host "Importing Websites..." -ForegroundColor Yellow
if (Test-Path "`$InputPath\iis-websites.json") {
    `$websitesJson = Get-Content -Path "`$InputPath\iis-websites.json" -Raw
    `$websites = ConvertFrom-Json -InputObject `$websitesJson

    foreach (`$site in `$websites) {
        `$siteName = `$site.Name
        
        # Skip sites that had errors during export
        if (`$site.ErrorProcessing) {
            Write-Warning "Website '`$siteName' had errors during export. Consider configuring it manually."
            continue
        }
        
        # Check if website exists
        if (Test-Path "IIS:\Sites\`$siteName") {
            Write-Host "Website '`$siteName' already exists. Skipping..." -ForegroundColor Yellow
            continue
        }
        
        # Create website
        Write-Host "Creating Website: `$siteName" -ForegroundColor Green
        
        # Create first binding
        `$firstBinding = if (`$site.Bindings -and `$site.Bindings.Count -gt 0) { `$site.Bindings[0] } else { `$null }
        `$bindingParams = @{
            Name = `$siteName
            PhysicalPath = `$site.PhysicalPath
            ApplicationPool = `$site.ApplicationPool
        }
        
        if (`$firstBinding) {
            `$bindingParams.Add('HostHeader', '')
            `$bindingParams.Add('Port', 80)
            `$bindingParams.Add('IPAddress', '*')
            
            if (`$firstBinding.Protocol -eq 'https') {
                `$bindingParams.Port = 443
                `$bindingParams.Add('Ssl', `$true)
            }
            
            # Parse binding info (IP:Port:HostHeader)
            `$bindingInfo = `$firstBinding.BindingInformation -split ':'
            if (`$bindingInfo.Count -ge 3) {
                if (`$bindingInfo[0]) { `$bindingParams.IPAddress = `$bindingInfo[0] }
                if (`$bindingInfo[1]) { `$bindingParams.Port = [int]`$bindingInfo[1] }
                if (`$bindingInfo[2]) { `$bindingParams.HostHeader = `$bindingInfo[2] }
            }
        }
        
        # Ensure directory exists
        if (-not (Test-Path `$site.PhysicalPath)) {
            New-Item -ItemType Directory -Path `$site.PhysicalPath -Force | Out-Null
        }
        
        # Create website with first binding
        try {
            New-Website @bindingParams -Force
        } catch {
            Write-Warning "Error creating website `$siteName`: `$_"
            continue
        }
        
        # Add additional bindings
        if (`$site.Bindings -and `$site.Bindings.Count -gt 1) {
            for (`$i = 1; `$i -lt `$site.Bindings.Count; `$i++) {
                try {
                    `$binding = `$site.Bindings[`$i]
                    `$protocol = `$binding.Protocol
                    `$bindingInfo = `$binding.BindingInformation
                    
                    Write-Host "  Adding binding: `$protocol - `$bindingInfo" -ForegroundColor Green
                    
                    # Parse binding info (IP:Port:HostHeader)
                    `$parts = `$bindingInfo -split ':'
                    `$ip = if (`$parts.Count -gt 0) { `$parts[0] } else { '' }
                    `$port = if (`$parts.Count -gt 1) { `$parts[1] } else { '80' }
                    `$hostHeader = if (`$parts.Count -gt 2) { `$parts[2] } else { '' }
                    
                    `$bindingParams = @{
                        Name = `$siteName
                        Protocol = `$protocol
                        IPAddress = if (`$ip -eq '') { '*' } else { `$ip }
                        Port = [int]`$port
                        HostHeader = `$hostHeader
                    }
                    
                    if (`$protocol -eq 'https') {
                        if (`$binding.SslFlags) {
                            `$bindingParams.Add('SslFlags', `$binding.SslFlags)
                        }
                    }
                    
                    New-WebBinding @bindingParams
                } catch {
                    Write-Warning "Error adding binding to `$siteName`: `$_"
                }
            }
        }
        
        # Add applications and virtual directories
        if (`$site.Applications) {
            foreach (`$app in `$site.Applications) {
                try {
                    `$appPath = `$app.Path
                    
                    # Skip root application (already created with website)
                    if (`$appPath -eq '/') {
                        continue
                    }
                    
                    # Ensure directory exists
                    if (-not (Test-Path `$app.PhysicalPath)) {
                        New-Item -ItemType Directory -Path `$app.PhysicalPath -Force | Out-Null
                    }
                    
                    Write-Host "  Creating application: `$appPath" -ForegroundColor Green
                    New-WebApplication -Site `$siteName -Name (`$appPath -replace '^/', '') -PhysicalPath `$app.PhysicalPath -ApplicationPool `$app.ApplicationPool -Force
                    
                    # Add virtual directories
                    if (`$app.VirtualDirectories) {
                        foreach (`$vdir in `$app.VirtualDirectories) {
                            try {
                                `$vdirPath = `$vdir.Path
                                
                                # Ensure directory exists
                                if (-not (Test-Path `$vdir.PhysicalPath)) {
                                    New-Item -ItemType Directory -Path `$vdir.PhysicalPath -Force | Out-Null
                                }
                                
                                Write-Host "    Creating virtual directory: `$vdirPath" -ForegroundColor Green
                                New-WebVirtualDirectory -Site `$siteName -Application `$appPath -Name (`$vdirPath -replace '^/', '') -PhysicalPath `$vdir.PhysicalPath
                            } catch {
                                Write-Warning "Error creating virtual directory `$vdirPath`: `$_"
                            }
                        }
                    }
                } catch {
                    Write-Warning "Error creating application `$appPath`: `$_"
                }
            }
        }
    }
} else {
    Write-Warning "Websites file not found: `$InputPath\iis-websites.json"
}

Write-Host "IIS Websites and Application Pools installation complete!" -ForegroundColor Green
"@

    $installScriptFile = "$OutputPath\Install-IISWebsitesAndPools.ps1"
    $installScript | Out-File -FilePath $installScriptFile -Encoding UTF8
    Write-Host "Installation script created at $installScriptFile" -ForegroundColor Green
    
} catch {
    Write-Error "Error creating installation script: $_"
}

# Final summary
Write-Host "IIS websites and application pools export completed" -ForegroundColor Green
Write-Host "Output files:" -ForegroundColor Green
Write-Host " - $OutputPath\iis-apppools.json" -ForegroundColor Green
Write-Host " - $OutputPath\iis-websites.json" -ForegroundColor Green
Write-Host " - $OutputPath\Install-IISWebsitesAndPools.ps1" -ForegroundColor Green 