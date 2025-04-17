# IIS Websites and Application Pools Installation Script
[CmdletBinding()]
param(
    [Parameter()]
    [string]$InputPath = "."
)

Write-Host "Installing IIS Websites and Application Pools..." -ForegroundColor Cyan

# Ensure WebAdministration module is loaded
try {
    if ($PSVersionTable.PSEdition -eq 'Core') {
        Import-Module WebAdministration -SkipEditionCheck -ErrorAction Stop
    } else {
        Import-Module WebAdministration -ErrorAction Stop
    }
} catch {
    Write-Error "Could not load WebAdministration module. This function requires the module to be installed."
    Write-Error "Run: Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementScriptingTools -NoRestart"
    return
}

# 1. Import Application Pools
Write-Host "Importing Application Pools..." -ForegroundColor Yellow
if (Test-Path "$InputPath\iis-apppools.json") {
    $appPoolsJson = Get-Content -Path "$InputPath\iis-apppools.json" -Raw
    $appPools = ConvertFrom-Json -InputObject $appPoolsJson

    foreach ($pool in $appPools) {
        $poolName = $pool.Name
        
        # Check if app pool exists
        if (Test-Path "IIS:\AppPools\$poolName") {
            Write-Host "Application Pool '$poolName' already exists. Skipping..." -ForegroundColor Yellow
            continue
        }
        
        # Create app pool
        Write-Host "Creating Application Pool: $poolName" -ForegroundColor Green
        New-WebAppPool -Name $poolName
        
        # Configure app pool
        if ($pool.ManagedRuntimeVersion -ne $null) {
            Set-ItemProperty -Path "IIS:\AppPools\$poolName" -Name managedRuntimeVersion -Value $pool.ManagedRuntimeVersion
        }
        
        if ($pool.ManagedPipelineMode -ne $null) {
            Set-ItemProperty -Path "IIS:\AppPools\$poolName" -Name managedPipelineMode -Value $pool.ManagedPipelineMode
        }
        
        if ($pool.AutoStart -ne $null) {
            Set-ItemProperty -Path "IIS:\AppPools\$poolName" -Name autoStart -Value $pool.AutoStart
        }
        
        if ($pool.StartMode) {
            Set-ItemProperty -Path "IIS:\AppPools\$poolName" -Name startMode -Value $pool.StartMode
        }
        
        # Configure process model
        if ($pool.ProcessModel) {
            try {
                if ($pool.ProcessModel.IdentityType) {
                    Set-ItemProperty -Path "IIS:\AppPools\$poolName" -Name processModel.identityType -Value $pool.ProcessModel.IdentityType
                }
                
                if ($pool.ProcessModel.IdleTimeout) {
                    Set-ItemProperty -Path "IIS:\AppPools\$poolName" -Name processModel.idleTimeout -Value ([TimeSpan]::FromMinutes($pool.ProcessModel.IdleTimeout))
                }
                
                if ($pool.ProcessModel.MaxProcesses) {
                    Set-ItemProperty -Path "IIS:\AppPools\$poolName" -Name processModel.maxProcesses -Value $pool.ProcessModel.MaxProcesses
                }
                
                if ($pool.ProcessModel.PingingEnabled -ne $null) {
                    Set-ItemProperty -Path "IIS:\AppPools\$poolName" -Name processModel.pingingEnabled -Value $pool.ProcessModel.PingingEnabled
                }
                
                if ($pool.ProcessModel.PingInterval) {
                    Set-ItemProperty -Path "IIS:\AppPools\$poolName" -Name processModel.pingInterval -Value ([TimeSpan]::FromSeconds($pool.ProcessModel.PingInterval))
                }
                
                if ($pool.ProcessModel.PingResponseTime) {
                    Set-ItemProperty -Path "IIS:\AppPools\$poolName" -Name processModel.pingResponseTime -Value ([TimeSpan]::FromSeconds($pool.ProcessModel.PingResponseTime))
                }
                
                if ($pool.ProcessModel.ShutdownTimeLimit) {
                    Set-ItemProperty -Path "IIS:\AppPools\$poolName" -Name processModel.shutdownTimeLimit -Value ([TimeSpan]::FromSeconds($pool.ProcessModel.ShutdownTimeLimit))
                }
                
                if ($pool.ProcessModel.StartupTimeLimit) {
                    Set-ItemProperty -Path "IIS:\AppPools\$poolName" -Name processModel.startupTimeLimit -Value ([TimeSpan]::FromSeconds($pool.ProcessModel.StartupTimeLimit))
                }
            } catch {
                Write-Warning "Error setting process model properties for $poolName: $_"
            }
        }
    }
} else {
    Write-Warning "Application pool file not found: $InputPath\iis-apppools.json"
}

# 2. Import Websites
Write-Host "Importing Websites..." -ForegroundColor Yellow
if (Test-Path "$InputPath\iis-websites.json") {
    $websitesJson = Get-Content -Path "$InputPath\iis-websites.json" -Raw
    $websites = ConvertFrom-Json -InputObject $websitesJson

    foreach ($site in $websites) {
        $siteName = $site.Name
        
        # Skip sites that had errors during export
        if ($site.ErrorProcessing) {
            Write-Warning "Website '$siteName' had errors during export. Consider configuring it manually."
            continue
        }
        
        # Check if website exists
        if (Test-Path "IIS:\Sites\$siteName") {
            Write-Host "Website '$siteName' already exists. Skipping..." -ForegroundColor Yellow
            continue
        }
        
        # Create website
        Write-Host "Creating Website: $siteName" -ForegroundColor Green
        
        # Create first binding
        $firstBinding = if ($site.Bindings -and $site.Bindings.Count -gt 0) { $site.Bindings[0] } else { $null }
        $bindingParams = @{
            Name = $siteName
            PhysicalPath = $site.PhysicalPath
            ApplicationPool = $site.ApplicationPool
        }
        
        if ($firstBinding) {
            $bindingParams.Add('HostHeader', '')
            $bindingParams.Add('Port', 80)
            $bindingParams.Add('IPAddress', '*')
            
            if ($firstBinding.Protocol -eq 'https') {
                $bindingParams.Port = 443
                $bindingParams.Add('Ssl', $true)
            }
            
            # Parse binding info (IP:Port:HostHeader)
            $bindingInfo = $firstBinding.BindingInformation -split ':'
            if ($bindingInfo.Count -ge 3) {
                if ($bindingInfo[0]) { $bindingParams.IPAddress = $bindingInfo[0] }
                if ($bindingInfo[1]) { $bindingParams.Port = [int]$bindingInfo[1] }
                if ($bindingInfo[2]) { $bindingParams.HostHeader = $bindingInfo[2] }
            }
        }
        
        # Ensure directory exists
        if (-not (Test-Path $site.PhysicalPath)) {
            New-Item -ItemType Directory -Path $site.PhysicalPath -Force | Out-Null
        }
        
        # Create website with first binding
        try {
            New-Website @bindingParams -Force
        } catch {
            Write-Warning "Error creating website $siteName: $_"
            continue
        }
        
        # Add additional bindings
        if ($site.Bindings -and $site.Bindings.Count -gt 1) {
            for ($i = 1; $i -lt $site.Bindings.Count; $i++) {
                try {
                    $binding = $site.Bindings[$i]
                    $protocol = $binding.Protocol
                    $bindingInfo = $binding.BindingInformation
                    
                    Write-Host "  Adding binding: $protocol - $bindingInfo" -ForegroundColor Green
                    
                    # Parse binding info (IP:Port:HostHeader)
                    $parts = $bindingInfo -split ':'
                    $ip = if ($parts.Count -gt 0) { $parts[0] } else { '' }
                    $port = if ($parts.Count -gt 1) { $parts[1] } else { '80' }
                    $hostHeader = if ($parts.Count -gt 2) { $parts[2] } else { '' }
                    
                    $bindingParams = @{
                        Name = $siteName
                        Protocol = $protocol
                        IPAddress = if ($ip -eq '') { '*' } else { $ip }
                        Port = [int]$port
                        HostHeader = $hostHeader
                    }
                    
                    if ($protocol -eq 'https') {
                        if ($binding.SslFlags) {
                            $bindingParams.Add('SslFlags', $binding.SslFlags)
                        }
                    }
                    
                    New-WebBinding @bindingParams
                } catch {
                    Write-Warning "Error adding binding to $siteName: $_"
                }
            }
        }
        
        # Add applications and virtual directories
        if ($site.Applications) {
            foreach ($app in $site.Applications) {
                try {
                    $appPath = $app.Path
                    
                    # Skip root application (already created with website)
                    if ($appPath -eq '/') {
                        continue
                    }
                    
                    # Ensure directory exists
                    if (-not (Test-Path $app.PhysicalPath)) {
                        New-Item -ItemType Directory -Path $app.PhysicalPath -Force | Out-Null
                    }
                    
                    Write-Host "  Creating application: $appPath" -ForegroundColor Green
                    New-WebApplication -Site $siteName -Name ($appPath -replace '^/', '') -PhysicalPath $app.PhysicalPath -ApplicationPool $app.ApplicationPool -Force
                    
                    # Add virtual directories
                    if ($app.VirtualDirectories) {
                        foreach ($vdir in $app.VirtualDirectories) {
                            try {
                                $vdirPath = $vdir.Path
                                
                                # Ensure directory exists
                                if (-not (Test-Path $vdir.PhysicalPath)) {
                                    New-Item -ItemType Directory -Path $vdir.PhysicalPath -Force | Out-Null
                                }
                                
                                Write-Host "    Creating virtual directory: $vdirPath" -ForegroundColor Green
                                New-WebVirtualDirectory -Site $siteName -Application $appPath -Name ($vdirPath -replace '^/', '') -PhysicalPath $vdir.PhysicalPath
                            } catch {
                                Write-Warning "Error creating virtual directory $vdirPath: $_"
                            }
                        }
                    }
                } catch {
                    Write-Warning "Error creating application $appPath: $_"
                }
            }
        }
    }
} else {
    Write-Warning "Websites file not found: $InputPath\iis-websites.json"
}

Write-Host "IIS Websites and Application Pools installation complete!" -ForegroundColor Green
