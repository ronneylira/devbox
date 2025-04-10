# Export all installed Windows Features including IIS and add-ons

function Export-WindowsFeatures {
    [CmdletBinding()]
    param(
        [string]$OutputPath = "."
    )
    
    Write-Host "Exporting installed Windows Features..."
    
    # For Windows 11/10, use Get-WindowsOptionalFeature
    if ([Environment]::OSVersion.Version.Major -ge 10) {
        $installedFeatures = Get-WindowsOptionalFeature -Online | Where-Object { $_.State -eq 'Enabled' }
        $featuresExport = $installedFeatures | Select-Object FeatureName, State
        $featuresExport | ConvertTo-Json | Out-File -FilePath "$OutputPath\windows-optional-features.json"
        
        # Create a list of IIS-related features
        $iisFeatures = $installedFeatures | Where-Object { $_.FeatureName -like 'IIS-*' } | Select-Object FeatureName
        $iisFeatures | ConvertTo-Json | Out-File -FilePath "$OutputPath\iis-features.json"
    }
    
    # If on a server, also try Get-WindowsFeature (more comprehensive)
    try {
        if (Get-Command Get-WindowsFeature -ErrorAction SilentlyContinue) {
            $serverFeatures = Get-WindowsFeature | Where-Object { $_.Installed -eq $true }
            $serverFeaturesExport = $serverFeatures | Select-Object Name, DisplayName, Installed
            $serverFeaturesExport | ConvertTo-Json | Out-File -FilePath "$OutputPath\windows-server-features.json"
            
            # Create a list of IIS-related server features
            $iisServerFeatures = $serverFeatures | Where-Object { $_.Name -like 'Web-*' } | Select-Object Name
            $iisServerFeatures | ConvertTo-Json | Out-File -FilePath "$OutputPath\iis-server-features.json"
        }
    } catch {
        Write-Host "Get-WindowsFeature not available, skipping server features export."
    }
    
    # Generate DSC configuration for Windows Features
    Generate-WindowsFeaturesDsc -OutputPath $OutputPath
}

function Generate-WindowsFeaturesDsc {
    [CmdletBinding()]
    param(
        [string]$OutputPath = "."
    )
    
    Write-Host "Generating DSC configuration for Windows Features..."
    
    $dscConfig = @"
# Windows Features DSC Configuration
Configuration WindowsFeatures {
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    
    Node localhost {
"@

    # Add Windows Optional Features if available
    if (Test-Path "$OutputPath\windows-optional-features.json") {
        $features = Get-Content "$OutputPath\windows-optional-features.json" | ConvertFrom-Json
        foreach ($feature in $features) {
            $featureName = $feature.FeatureName
            $safeFeatureName = $featureName -replace '[^a-zA-Z0-9]', ''
            
            $dscConfig += @"
        # Windows Optional Feature: $featureName
        Script $safeFeatureName {
            SetScript = {
                Enable-WindowsOptionalFeature -Online -FeatureName "$featureName" -NoRestart
            }
            TestScript = {
                return (Get-WindowsOptionalFeature -Online -FeatureName "$featureName").State -eq "Enabled"
            }
            GetScript = {
                return @{
                    Result = (Get-WindowsOptionalFeature -Online -FeatureName "$featureName").State
                }
            }
        }

"@
        }
    }
    
    # Add Windows Server Features if available
    if (Test-Path "$OutputPath\windows-server-features.json") {
        $serverFeatures = Get-Content "$OutputPath\windows-server-features.json" | ConvertFrom-Json
        foreach ($feature in $serverFeatures) {
            $featureName = $feature.Name
            $safeFeatureName = $featureName -replace '[^a-zA-Z0-9]', ''
            
            $dscConfig += @"
        # Windows Server Feature: $featureName
        WindowsFeature $safeFeatureName {
            Name = "$featureName"
            Ensure = "Present"
        }

"@
        }
    }
    
    # Close the configuration
    $dscConfig += @"
    }
}
"@

    # Write configuration to file
    $dscConfig | Out-File -FilePath "$OutputPath\WindowsFeatures-DSC.ps1"
    Write-Host "DSC Configuration for Windows Features has been generated at $OutputPath\WindowsFeatures-DSC.ps1"
}

# Execute the function only if script is run directly (not dot-sourced)
if ($MyInvocation.InvocationName -ne '.') {
    Export-WindowsFeatures
}