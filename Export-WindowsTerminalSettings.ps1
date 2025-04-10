# Export Windows Terminal settings and profiles

function Export-WindowsTerminalSettings {
    [CmdletBinding()]
    param(
        [string]$ExportPath = ".\windows-terminal"
    )
    
    Write-Host "Exporting Windows Terminal settings and profiles..." -ForegroundColor Cyan
    
    # Create export directory if it doesn't exist
    if (-not (Test-Path $ExportPath)) {
        New-Item -ItemType Directory -Path $ExportPath -Force | Out-Null
    }
    
    # Possible locations for Windows Terminal settings.json file
    $possiblePaths = @(
        # Windows Store version (most common)
        "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json",
        # Windows Terminal Preview
        "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json",
        # Non-Store version
        "$env:LOCALAPPDATA\Microsoft\Windows Terminal\settings.json"
    )
    
    $settingsFound = $false
    
    foreach ($path in $possiblePaths) {
        if (Test-Path $path) {
            try {
                Write-Host "Found Windows Terminal settings at: $path" -ForegroundColor Green
                
                # Copy the settings file
                Copy-Item -Path $path -Destination "$ExportPath\settings.json" -Force
                
                # Try to parse the JSON to check if it's valid
                $settings = Get-Content -Path $path | ConvertFrom-Json
                $settingsFound = $true
                
                # Output some info about the profiles found
                Write-Host "Exported Windows Terminal settings with the following profiles:" -ForegroundColor Green
                $settings.profiles.list | ForEach-Object {
                    Write-Host "  - $($_.name)" -ForegroundColor Green
                }
                
                # Create the installation script
                $installScript = @'
# Windows Terminal Settings Installation Script
[CmdletBinding()]
param(
    [string]$SourcePath = ".\windows-terminal"
)

Write-Host "Installing Windows Terminal settings..." -ForegroundColor Cyan

# Check if settings file exists in the source
$sourceSettingsFile = Join-Path $SourcePath "settings.json"
if (-not (Test-Path $sourceSettingsFile)) {
    Write-Error "Windows Terminal settings file not found at $sourceSettingsFile"
    return
}

# Possible locations for Windows Terminal settings.json file
$possiblePaths = @(
    # Windows Store version (most common)
    "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json",
    # Windows Terminal Preview
    "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json",
    # Non-Store version
    "$env:LOCALAPPDATA\Microsoft\Windows Terminal\settings.json"
)

$settingsInstalled = $false

# First check if any Windows Terminal instance is installed
foreach ($path in $possiblePaths) {
    $directory = Split-Path -Parent $path
    if (Test-Path $directory) {
        # Create a backup of current settings if they exist
        if (Test-Path $path) {
            $backupPath = "$path.backup"
            Write-Host "Creating backup of existing settings at $backupPath"
            Copy-Item -Path $path -Destination $backupPath -Force
        }
        
        # Copy the new settings
        try {
            Copy-Item -Path $sourceSettingsFile -Destination $path -Force
            Write-Host "Windows Terminal settings installed successfully at $path" -ForegroundColor Green
            $settingsInstalled = $true
            break  # Once installed to one location, we're done
        }
        catch {
            Write-Warning "Failed to install settings to $path`: $_"
        }
    }
}

if (-not $settingsInstalled) {
    # No existing Windows Terminal installation found, but we can put it in the default location
    $defaultPath = "$env:LOCALAPPDATA\Microsoft\Windows Terminal"
    $defaultSettings = "$defaultPath\settings.json"
    
    try {
        # Create the directory if it doesn't exist
        if (-not (Test-Path $defaultPath)) {
            New-Item -ItemType Directory -Path $defaultPath -Force | Out-Null
        }
        
        # Copy the settings file
        Copy-Item -Path $sourceSettingsFile -Destination $defaultSettings -Force
        Write-Host "Windows Terminal settings installed to default location: $defaultSettings" -ForegroundColor Green
        Write-Host "Note: You may need to install Windows Terminal from the Microsoft Store" -ForegroundColor Yellow
        $settingsInstalled = $true
    }
    catch {
        Write-Warning "Failed to install settings to default location: $_"
    }
}

if (-not $settingsInstalled) {
    Write-Warning "Could not find a suitable location to install Windows Terminal settings"
}
'@
                
                $installScript | Out-File -FilePath "$ExportPath\Install-WindowsTerminalSettings.ps1" -Encoding utf8
                Write-Host "Installation script created at $ExportPath\Install-WindowsTerminalSettings.ps1" -ForegroundColor Green
                
                # Once we've found and exported settings, we can break out of the loop
                break
            }
            catch {
                Write-Warning "Error exporting Windows Terminal settings from $path`: $_"
            }
        }
    }
    
    if (-not $settingsFound) {
        Write-Warning "Windows Terminal settings file not found."
        Write-Host "Windows Terminal might not be installed, or it's using a non-standard location." -ForegroundColor Yellow
    }
    
    return $settingsFound
}

# Execute the function
Export-WindowsTerminalSettings 