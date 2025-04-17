# Export SQL Server Management Studio Settings
# This script exports SQL Server Management Studio settings to a backup folder

param (
    [Parameter()]
    [string]$OutputPath = ".",  # Default to current directory like other scripts
    [string]$BackupLocation = "",  # Kept for backward compatibility
    [switch]$UseSqlServerFolder = $false  # If true, uses SQL Server folder instead of user profile
)

function Copy-SettingsFile {
    param (
        [string]$sourcePath,
        [string]$destinationPath
    )
    
    if (Test-Path -Path $sourcePath) {
        try {
            $destinationDir = Split-Path -Path $destinationPath -Parent
            if (-not (Test-Path -Path $destinationDir)) {
                New-Item -Path $destinationDir -ItemType Directory -Force | Out-Null
            }
            
            Copy-Item -Path $sourcePath -Destination $destinationPath -Force
            Write-Host "Successfully exported: $destinationPath" -ForegroundColor Green
            return $true
        }
        catch {
            Write-Host "Error copying $sourcePath to $destinationPath : $_" -ForegroundColor Red
            return $false
        }
    }
    else {
        Write-Host "Source file not found: $sourcePath" -ForegroundColor Yellow
        return $false
    }
}

# Determine backup directory
if ($BackupLocation) {
    # Use provided backup location
    $backupDir = Join-Path -Path $BackupLocation -ChildPath "SSMSBackup\$(Get-Date -Format 'yyyy-MM-dd_HHmmss')"
} elseif ($OutputPath -ne ".") {
    # Use OutputPath if specified (new parameter)
    $backupDir = $OutputPath
} elseif ($UseSqlServerFolder) {
    # Try to find SQL Server installation folder
    $sqlServerPath = "C:\Program Files\Microsoft SQL Server"
    if (Test-Path -Path $sqlServerPath) {
        $backupDir = Join-Path -Path $sqlServerPath -ChildPath "SSMSBackup\$(Get-Date -Format 'yyyy-MM-dd_HHmmss')"
    } else {
        Write-Host "SQL Server folder not found. Falling back to user profile." -ForegroundColor Yellow
        $backupDir = "$env:USERPROFILE\SSMSBackup\$(Get-Date -Format 'yyyy-MM-dd_HHmmss')"
    }
} else {
    # Default to OutputPath (current directory)
    $backupDir = $OutputPath
}

if (-not (Test-Path -Path $backupDir)) {
    New-Item -Path $backupDir -ItemType Directory -Force | Out-Null
}

# Display backup location
Write-Host "Settings will be backed up to: $backupDir" -ForegroundColor Cyan

# SSMS versions and paths
$ssmsVersions = @(
    @{
        Version = "20.0";
        Path = "$env:APPDATA\Microsoft\SQL Server Management Studio\20.0";
        Name = "SSMS 20"
    },
    @{
        Version = "19.0";
        Path = "$env:APPDATA\Microsoft\SQL Server Management Studio\19.0";
        Name = "SSMS 19"
    },
    @{
        Version = "18.0";
        Path = "$env:APPDATA\Microsoft\SQL Server Management Studio\18.0";
        Name = "SSMS 18"
    },
    @{
        Version = "17.0";
        Path = "$env:APPDATA\Microsoft\SQL Server Management Studio\17.0";
        Name = "SSMS 17"
    }
)

$exportedSettings = @()
$exportSuccessful = $false

# Export settings from each SSMS version
foreach ($ssms in $ssmsVersions) {
    $settingsPath = $ssms.Path
    $settingsVersion = $ssms.Version
    $settingsName = $ssms.Name
    
    Write-Host "Checking for $settingsName settings..." -ForegroundColor Cyan
    
    if (Test-Path -Path $settingsPath) {
        Write-Host "Found $settingsName settings at $settingsPath" -ForegroundColor Cyan
        
        # Current settings directory
        $backupVersionDir = Join-Path -Path $backupDir -ChildPath $settingsVersion
        New-Item -Path $backupVersionDir -ItemType Directory -Force | Out-Null
        
        # SSMS 20 uses different file format
        if ($settingsVersion -eq "20.0") {
            # Copy UserSettings.xml for SSMS 20
            $userSettingsFile = "$settingsPath\UserSettings.xml"
            $userSettingsDestination = "$backupVersionDir\UserSettings.xml"
            
            if (Copy-SettingsFile -sourcePath $userSettingsFile -destinationPath $userSettingsDestination) {
                $exportedSettings += @{
                    Version = $settingsVersion;
                    SourceFile = $userSettingsFile;
                    BackupFile = $userSettingsDestination;
                    Name = $settingsName
                }
                $exportSuccessful = $true
            }
            
            # Look for any other XML files that might contain settings
            $otherXmlFiles = Get-ChildItem -Path "$settingsPath\*.xml" -Exclude "UserSettings.xml" -ErrorAction SilentlyContinue
            foreach ($xmlFile in $otherXmlFiles) {
                $destFile = Join-Path -Path $backupVersionDir -ChildPath $xmlFile.Name
                if (Copy-SettingsFile -sourcePath $xmlFile.FullName -destinationPath $destFile) {
                    $exportedSettings += @{
                        Version = $settingsVersion;
                        SourceFile = $xmlFile.FullName;
                        BackupFile = $destFile;
                        Name = "$settingsName - $(Split-Path -Path $xmlFile.Name -Leaf)"
                    }
                    $exportSuccessful = $true
                }
            }
        } else {
            # Standard settings files for older SSMS versions
            $settingsFiles = @(
                @{ Source = "$settingsPath\Settings\CurrentSettings.vssettings"; Destination = "$backupVersionDir\CurrentSettings.vssettings" },
                @{ Source = "$settingsPath\Settings\CurrentSettings-15.0.vssettings"; Destination = "$backupVersionDir\CurrentSettings-15.0.vssettings" }
            )
            
            foreach ($file in $settingsFiles) {
                if (Copy-SettingsFile -sourcePath $file.Source -destinationPath $file.Destination) {
                    $exportedSettings += @{
                        Version = $settingsVersion;
                        SourceFile = $file.Source;
                        BackupFile = $file.Destination;
                        Name = $settingsName
                    }
                    $exportSuccessful = $true
                }
            }
            
            # Copy Keyboard Schemes
            $keyboardSchemes = Get-ChildItem -Path "$settingsPath\Settings\CurrentSettings-*.vssettings" -ErrorAction SilentlyContinue
            foreach ($scheme in $keyboardSchemes) {
                $destFile = Join-Path -Path $backupVersionDir -ChildPath $scheme.Name
                if (Copy-SettingsFile -sourcePath $scheme.FullName -destinationPath $destFile) {
                    $exportedSettings += @{
                        Version = $settingsVersion;
                        SourceFile = $scheme.FullName;
                        BackupFile = $destFile;
                        Name = "$settingsName - Keyboard Scheme"
                    }
                    $exportSuccessful = $true
                }
            }
        }
    }
    else {
        Write-Host "No $settingsName settings found at $settingsPath" -ForegroundColor Yellow
    }
}

# Create manual instructions file
$instructionsContent = @"
# SQL Server Management Studio Settings Backup

Backup Date: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

## Settings Exported:

"@

foreach ($setting in $exportedSettings) {
    $instructionsContent += @"

- $($setting.Name) (Version $($setting.Version)):
  - Original: $($setting.SourceFile)
  - Backup: $($setting.BackupFile)

"@
}

# Create installation instructions
$installInstructions = @"

## How to Import Settings:

1. Open SQL Server Management Studio
2. Go to Tools -> Import and Export Settings...
3. Select "Import selected environment settings" and click Next
4. Choose whether to save current settings (recommended)
5. Click "Browse" and navigate to one of the backup files listed above
6. Follow the wizard to complete the import

## Manual Copy:

You can also manually copy the backup files to their original locations:

"@

foreach ($setting in $exportedSettings) {
    $installInstructions += @"

- Copy: $($setting.BackupFile)
  To: $($setting.SourceFile)

"@
}

$instructionsContent += $installInstructions
$instructionsPath = Join-Path -Path $backupDir -ChildPath "ImportInstructions.md"
$instructionsContent | Out-File -FilePath $instructionsPath -Encoding utf8

if ($exportSuccessful) {
    Write-Host "`nSettings backup completed successfully!" -ForegroundColor Green
    Write-Host "Backup location: $backupDir" -ForegroundColor Green
    Write-Host "See $instructionsPath for import instructions." -ForegroundColor Green
} else {
    Write-Host "`nNo settings were exported. Please make sure SQL Server Management Studio is installed." -ForegroundColor Red
}

# Create installation script similar to other export scripts
if ($exportSuccessful) {
    $installScript = @"
# SQL Server Management Studio Settings Import Script
[CmdletBinding()]
param(
    [Parameter()]
    [string]`$InputPath = ".",
    [Parameter()]
    [switch]`$ManualInstructionsOnly = `$false
)

Write-Host "Importing SQL Server Management Studio settings..." -ForegroundColor Cyan

if (`$ManualInstructionsOnly) {
    # Display manual instructions only
    Get-Content -Path (Join-Path -Path `$InputPath -ChildPath "ImportInstructions.md") -ErrorAction SilentlyContinue
    Write-Host "`nFor SQL Server Management Studio settings, manual import is recommended." -ForegroundColor Yellow
    Write-Host "Please follow the instructions above to import settings using the SSMS UI." -ForegroundColor Yellow
    return
}

# Try to perform automatic import for each SSMS version
`$versionsFound = Get-ChildItem -Path `$InputPath -Directory -ErrorAction SilentlyContinue | Where-Object { `$_.Name -match "^\d+\.\d+$" }

if (-not `$versionsFound) {
    Write-Host "No SQL Server Management Studio settings found in `$InputPath" -ForegroundColor Yellow
    Write-Host "Please check the import directory and try again, or use manual import." -ForegroundColor Yellow
    return
}

`$importSuccessful = `$false

foreach (`$versionDir in `$versionsFound) {
    `$version = `$versionDir.Name
    `$targetDirectory = "`$env:APPDATA\Microsoft\SQL Server Management Studio\`$version"
    
    Write-Host "Importing settings for SSMS version `$version..." -ForegroundColor Cyan
    
    # For SSMS 20.0, we have a different approach
    if (`$version -eq "20.0") {
        if (Test-Path (Join-Path -Path `$versionDir.FullName -ChildPath "UserSettings.xml")) {
            # Create target directory if it doesn't exist
            if (-not (Test-Path `$targetDirectory)) {
                try {
                    New-Item -Path `$targetDirectory -ItemType Directory -Force | Out-Null
                    Write-Host "Created directory: `$targetDirectory" -ForegroundColor Gray
                }
                catch {
                    Write-Warning "Could not create directory `$targetDirectory: `$_"
                    continue
                }
            }
            
            try {
                Copy-Item -Path (Join-Path -Path `$versionDir.FullName -ChildPath "UserSettings.xml") -Destination "`$targetDirectory\UserSettings.xml" -Force
                Write-Host "SSMS `$version settings imported successfully" -ForegroundColor Green
                `$importSuccessful = `$true
            }
            catch {
                Write-Warning "Error importing SSMS `$version settings: `$_"
            }
        }
    }
    else {
        # For older SSMS versions, look for vssettings files
        `$settingsFiles = Get-ChildItem -Path `$versionDir.FullName -Filter "*.vssettings" -ErrorAction SilentlyContinue
        
        if (`$settingsFiles) {
            # Create target settings directory if it doesn't exist
            `$targetSettingsDir = "`$targetDirectory\Settings"
            if (-not (Test-Path `$targetSettingsDir)) {
                try {
                    New-Item -Path `$targetSettingsDir -ItemType Directory -Force | Out-Null
                    Write-Host "Created directory: `$targetSettingsDir" -ForegroundColor Gray
                }
                catch {
                    Write-Warning "Could not create directory `$targetSettingsDir: `$_"
                    continue
                }
            }
            
            foreach (`$file in `$settingsFiles) {
                try {
                    Copy-Item -Path `$file.FullName -Destination "`$targetSettingsDir\`$(`$file.Name)" -Force
                    Write-Host "SSMS `$version setting file `$(`$file.Name) imported successfully" -ForegroundColor Green
                    `$importSuccessful = `$true
                }
                catch {
                    Write-Warning "Error importing SSMS `$version setting file `$(`$file.Name): `$_"
                }
            }
        }
    }
}

if (`$importSuccessful) {
    Write-Host "SQL Server Management Studio settings import completed" -ForegroundColor Green
    Write-Host "Note: Some settings may require restarting SSMS to take effect" -ForegroundColor Yellow
}
else {
    Write-Host "No settings were imported. Consider using manual import." -ForegroundColor Yellow
    Write-Host "Run this script with -ManualInstructionsOnly to see manual import instructions" -ForegroundColor Yellow
}
"@

    $installScriptPath = Join-Path -Path $backupDir -ChildPath "Install-SQLServerSettings.ps1"
    $installScript | Out-File -FilePath $installScriptPath -Encoding UTF8
    
    Write-Host "Installation script created at: $installScriptPath" -ForegroundColor Green
} 