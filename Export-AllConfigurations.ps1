# Comprehensive configuration export with all components
Write-Host "Starting comprehensive configuration export..." -ForegroundColor Green

# Create timestamp for the export
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$exportDir = "DevboxExport-$timestamp"
New-Item -ItemType Directory -Path $exportDir -Force | Out-Null
Set-Location $exportDir

# Create module-specific directories
$moduleDirectories = @(
    "chocolatey",
    "winget",
    "windows-features",
    "iis",
    "powershell",
    "environment",
    "git",
    "vscode",
    "windows-terminal",
    "browser-bookmarks",
    "sqlserver",
    "oh-my-posh"
)

foreach ($dir in $moduleDirectories) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "Created module directory: $dir" -ForegroundColor Gray
    }
}

# 1. Export installed packages
Write-Host "Exporting installed packages..." -ForegroundColor Cyan
# Export Chocolatey packages
if (Get-Command choco -ErrorAction SilentlyContinue) {
    Write-Host "Exporting Chocolatey packages..."
    choco list --local-only --limit-output > .\chocolatey\choco-packages.txt
    
    $chocoPackages = Get-Content .\chocolatey\choco-packages.txt
    $installScript = "# Chocolatey package installation`r`n"
    foreach ($package in $chocoPackages) {
        $pkgName = ($package -split '\|')[0]
        $installScript += "choco install $pkgName -y`r`n"
    }
    $installScript | Out-File -FilePath .\chocolatey\install-choco-packages.ps1
}

# Export WinGet packages
if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Host "Exporting WinGet packages..."
    winget export -o .\winget\winget-packages.json
}

# 2. Export Windows Features (including IIS itself)
Write-Host "Exporting Windows Features..." -ForegroundColor Cyan
$currentLocation = Get-Location
Set-Location .\windows-features
. ..\..\Export-WindowsFeatures.ps1
Set-Location $currentLocation

# 3. Export IIS configuration
Write-Host "Exporting IIS configuration..." -ForegroundColor Cyan

# Determine PowerShell version and use appropriate commands
$isPSCore = $PSVersionTable.PSEdition -eq 'Core'
Write-Host "Detected PowerShell $($PSVersionTable.PSVersion) ($($PSVersionTable.PSEdition))" -ForegroundColor Cyan

# Try to import the WebAdministration module first
try {
    # First check if module exists
    if (-not (Get-Module -Name WebAdministration -ErrorAction SilentlyContinue)) {
        Write-Host "Attempting to import WebAdministration module..."
        
        if ($isPSCore) {
            # PowerShell 7/Core needs special handling
            Write-Host "PowerShell Core detected, using compatibility mode for WebAdministration" -ForegroundColor Yellow
            Import-Module WebAdministration -SkipEditionCheck -ErrorAction Stop
        } else {
            # Windows PowerShell 5.1
            Import-Module WebAdministration -ErrorAction Stop
        }
        
        Write-Host "WebAdministration module imported successfully." -ForegroundColor Green
    }
} catch {
    Write-Host "Attempting to install WebAdministration prerequisites..." -ForegroundColor Yellow
    
    # Try to enable the required Windows features
    try {
        Write-Host "Enabling IIS Management Scripting Tools..."
        
        if ($isPSCore) {
            # For PowerShell Core, use DISM instead of Enable-WindowsOptionalFeature
            Write-Host "Using DISM to enable Windows features in PowerShell Core" -ForegroundColor Yellow
            Start-Process -FilePath "DISM.exe" -ArgumentList "/Online /Enable-Feature /FeatureName:IIS-ManagementScriptingTools /All" -Wait -NoNewWindow
            Start-Process -FilePath "DISM.exe" -ArgumentList "/Online /Enable-Feature /FeatureName:IIS-WebServerManagementTools /All" -Wait -NoNewWindow
            Start-Process -FilePath "DISM.exe" -ArgumentList "/Online /Enable-Feature /FeatureName:IIS-ManagementConsole /All" -Wait -NoNewWindow
        } else {
            # Windows PowerShell can use Enable-WindowsOptionalFeature
            Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementScriptingTools -NoRestart
            Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerManagementTools -NoRestart
            Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole -NoRestart
        }
        
        # Try importing again, with PowerShell edition awareness
        if ($isPSCore) {
            Import-Module WebAdministration -SkipEditionCheck -ErrorAction Stop
        } else {
            Import-Module WebAdministration -ErrorAction Stop
        }
        
        Write-Host "WebAdministration module installed and imported successfully." -ForegroundColor Green
    } catch {
        Write-Warning "Failed to install or import WebAdministration module: $_"
    }
}

# Check if the module was loaded successfully
$moduleLoaded = $false
if ($isPSCore) {
    $moduleLoaded = Get-Module -Name WebAdministration -SkipEditionCheck -ErrorAction SilentlyContinue
} else {
    $moduleLoaded = Get-Module -ListAvailable -Name WebAdministration -ErrorAction SilentlyContinue
}

if ($moduleLoaded) {
    # Set location to IIS directory for exports
    $currentLocation = Get-Location
    Set-Location .\iis
    
    # Run the IIS export script with the current directory as output path
    . ..\..\Export-IISConfig.ps1 -OutputPath .
    
    # Export IIS modules and handler mappings to the current directory
    . ..\..\Export-IISModules.ps1 -OutputPath .
    
    # Export IIS websites and application pools
    . ..\..\Export-IISWebsitesAndPools.ps1 -OutputPath .
    
    # Generate DSC configuration from IIS export with the current directory as output path
    . ..\..\Generate-IISDscConfig.ps1 -OutputPath .
    
    # Return to original location
    Set-Location $currentLocation
} else {
    Write-Warning "WebAdministration module not found or not loaded correctly. IIS export skipped."
    Write-Host "For PowerShell 7/Core users:" -ForegroundColor Yellow
    Write-Host "1. Try running this script in Windows PowerShell 5.1 instead" -ForegroundColor Yellow
    Write-Host "2. Or manually run: Import-Module WebAdministration -SkipEditionCheck" -ForegroundColor Yellow
    Write-Host "" -ForegroundColor Yellow
    Write-Host "To manually install IIS features, run these commands as administrator:" -ForegroundColor Yellow
    Write-Host "DISM.exe /Online /Enable-Feature /FeatureName:IIS-ManagementScriptingTools /All" -ForegroundColor Yellow
    Write-Host "DISM.exe /Online /Enable-Feature /FeatureName:IIS-WebServerManagementTools /All" -ForegroundColor Yellow
    Write-Host "DISM.exe /Online /Enable-Feature /FeatureName:IIS-ManagementConsole /All" -ForegroundColor Yellow
}

# 5. Export PowerShell modules
Write-Host "Exporting PowerShell modules..." -ForegroundColor Cyan
$currentLocation = Get-Location
Set-Location .\powershell
. ..\..\Export-PSModules.ps1
Set-Location $currentLocation

# 6. Export PowerShell profiles
Write-Host "Exporting PowerShell profiles..." -ForegroundColor Cyan
$currentLocation = Get-Location
Set-Location .\powershell
. ..\..\Export-PSProfiles.ps1
Set-Location $currentLocation

# 7. Export environment variables (enhanced)
Write-Host "Exporting environment variables..." -ForegroundColor Cyan
$currentLocation = Get-Location
Set-Location .\environment
. ..\..\Export-EnvVariables.ps1
Set-Location $currentLocation

# 8. Export VSCode extensions if VS Code is installed
Write-Host "Exporting VS Code extensions..." -ForegroundColor Cyan
if (Get-Command code -ErrorAction SilentlyContinue) {
    code --list-extensions > .\vscode\vscode-extensions.txt
    
    $installScript = @"
# VS Code Extensions Installation Script
Write-Host "Installing VS Code extensions..." -ForegroundColor Cyan

if (Get-Command code -ErrorAction SilentlyContinue) {
    Get-Content .\vscode-extensions.txt | ForEach-Object {
        Write-Host "Installing extension: $_"
        code --install-extension $_ --force
    }
} else {
    Write-Warning "VS Code not found. Extensions installation skipped."
}
"@
    $installScript | Out-File -FilePath .\vscode\Install-VSCodeExtensions.ps1
}

# Export Oh My Posh theme if installed
Write-Host "Exporting Oh My Posh theme configuration..." -ForegroundColor Cyan
$currentLocation = Get-Location
Set-Location .\oh-my-posh
. ..\..\Export-OhMyPoshTheme.ps1
Set-Location $currentLocation

# 9. Export Git configuration if Git is installed
Write-Host "Exporting Git configuration..." -ForegroundColor Cyan
if (Get-Command git -ErrorAction SilentlyContinue) {
    git config --list > .\git\git-config.txt
    
    $installScript = @"
# Git Configuration Installation Script
Write-Host "Setting up Git configuration..." -ForegroundColor Cyan

if (Get-Command git -ErrorAction SilentlyContinue) {
    `$gitConfig = Get-Content .\git-config.txt
    foreach (`$line in `$gitConfig) {
        if (`$line -match "^([^=]+)=(.*)$") {
            `$key = `$matches[1]
            `$value = `$matches[2]
            # Skip system-specific configurations
            if (`$key -notlike "filesystem.*" -and `$key -notlike "core.longpaths") {
                Write-Host "Setting Git config: `$key = `$value"
                git config --global "`$key" "`$value"
            }
        }
    }
} else {
    Write-Warning "Git not found. Git configuration skipped."
}
"@
    $installScript | Out-File -FilePath .\git\Install-GitConfig.ps1
}

# 10. Export browser bookmarks only (simplified version)
Write-Host "Exporting browser bookmarks..." -ForegroundColor Cyan
. ..\Export-SimpleBrowserProfiles.ps1 -ExportPath .\browser-bookmarks

# 11. Export Windows Terminal settings and profiles
Write-Host "Exporting Windows Terminal settings..." -ForegroundColor Cyan
. ..\Export-WindowsTerminalSettings.ps1 -ExportPath .\windows-terminal

# 11.1 Export Oh My Posh theme
Write-Host "Exporting Oh My Posh theme..." -ForegroundColor Cyan
. ..\Export-OhMyPoshTheme.ps1 -ExportPath .\oh-my-posh

# 11.2 Export SQL Server registered servers
Write-Host "Exporting SQL Server registered servers..." -ForegroundColor Cyan
$currentLocation = Get-Location
Set-Location .\sqlserver
. ..\..\Export-SQLRegisteredServers.ps1 -OutputPath .
Set-Location $currentLocation

# 11.3 Export SQL Server Management Studio settings
Write-Host "Exporting SQL Server Management Studio settings..." -ForegroundColor Cyan
$currentLocation = Get-Location
Set-Location .\sqlserver
. ..\..\Export-SQLServerSettings.ps1 -OutputPath .
Set-Location $currentLocation

# 12. Create comprehensive DSC configuration that includes all components
Write-Host "Creating comprehensive DSC configuration..." -ForegroundColor Cyan
$configScript = @"
Configuration CompleteEnvironment {
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName xWebAdministration
    
    Node localhost {
        # First, install Windows Features (including IIS)
        . .\windows-features\WindowsFeatures-DSC.ps1
        WindowsFeatures
        
        # Then configure IIS Modules
        . .\iis\IISModules-DSC.ps1
        IISModules
        
        # Finally, configure IIS websites, applications, etc.
        . .\iis\MyIISDscConfiguration.ps1
        MyIISConfiguration
    }
}
"@

$configScript | Out-File -FilePath .\CompleteEnvironment.ps1

# 13. Create a master installation script for new machine
$installScript = @"
# Master installation script for new machine
[CmdletBinding()]
param(
    [Parameter()]
    [switch]`$CreateDevDrive = `$true,
    
    [Parameter()]
    [string]`$DevDriveLetter = "D",
    
    [Parameter()]
    [int]`$DevDriveSize = 80,
    
    [Parameter()]
    [switch]`$ImportBrowserProfiles = `$true,
    
    [Parameter()]
    [switch]`$ImportBrowserBookmarksOnly = `$false,
    
    [Parameter()]
    [switch]`$SetupOhMyPosh = `$true
)

Write-Host "Starting comprehensive environment setup..." -ForegroundColor Green

# 1. Install required modules
Write-Host "Installing required PowerShell modules..." -ForegroundColor Cyan
if (-not (Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)) {
    Install-PackageProvider -Name NuGet -Force
}

if (-not (Get-Module -ListAvailable -Name xWebAdministration)) {
    Install-Module -Name xWebAdministration -Force
}

if (-not (Get-Module -ListAvailable -Name PSDscResources)) {
    Install-Module -Name PSDscResources -Force
}

# 2. Create DevDrive if requested
if (`$CreateDevDrive) {
    Write-Host "Setting up DevDrive..." -ForegroundColor Cyan
    . .\Setup-DevDrive.ps1
    Setup-DevDrive -DriveLetter `$DevDriveLetter -SizeGB `$DevDriveSize -Label "DevDrive"
}

# 3. Install Chocolatey (if needed) and packages
Write-Host "Installing software packages..." -ForegroundColor Cyan
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

if (Test-Path .\chocolatey\install-choco-packages.ps1) {
    Write-Host "Installing Chocolatey packages..."
    & .\chocolatey\install-choco-packages.ps1
}

# 4. Install WinGet packages (if available)
if ((Get-Command winget -ErrorAction SilentlyContinue) -and (Test-Path .\winget\winget-packages.json)) {
    Write-Host "Installing WinGet packages..."
    winget import -i .\winget\winget-packages.json
}

# 5. Install PowerShell modules
if (Test-Path .\powershell\Install-PSModules.ps1) {
    Write-Host "Installing PowerShell modules..."
    & .\powershell\Install-PSModules.ps1
}

# 6. Install PowerShell profiles
if (Test-Path .\powershell\Install-PSProfiles.ps1) {
    Write-Host "Installing PowerShell profiles..."
    & .\powershell\Install-PSProfiles.ps1
}

# 7. Setup environment variables
if (Test-Path .\environment\Install-EnvVariables.ps1) {
    Write-Host "Setting up environment variables..."
    & .\environment\Install-EnvVariables.ps1
}

# 8. Install VS Code extensions
if (Test-Path .\vscode\Install-VSCodeExtensions.ps1) {
    Write-Host "Installing VS Code extensions..."
    & .\vscode\Install-VSCodeExtensions.ps1
}

# 9. Configure Git
if (Test-Path .\git\Install-GitConfig.ps1) {
    Write-Host "Configuring Git..."
    & .\git\Install-GitConfig.ps1
}

# 10. Import browser bookmarks
if (`$ImportBrowserProfiles -and (Test-Path .\browser-bookmarks\Install-BrowserBookmarks.ps1)) {
    Write-Host "Importing browser bookmarks..." -ForegroundColor Cyan
    & .\browser-bookmarks\Install-BrowserBookmarks.ps1
}

# 11. Import Windows Terminal settings
if (Test-Path .\windows-terminal\Install-WindowsTerminalSettings.ps1) {
    Write-Host "Importing Windows Terminal settings..." -ForegroundColor Cyan
    & .\windows-terminal\Install-WindowsTerminalSettings.ps1
}

# 11.1 Import Oh My Posh theme
if (`$SetupOhMyPosh -and (Test-Path .\oh-my-posh\Install-OhMyPosh.ps1)) {
    Write-Host "Setting up Oh My Posh..." -ForegroundColor Cyan
    & .\oh-my-posh\Install-OhMyPosh.ps1
}

# 11.2 Import SQL Server registered servers
if (Test-Path .\sqlserver\Install-SQLRegisteredServers.ps1) {
    Write-Host "Importing SQL Server registered servers..." -ForegroundColor Cyan
    & .\sqlserver\Install-SQLRegisteredServers.ps1
}

# 11.3 Import SQL Server Management Studio settings
if (Test-Path .\sqlserver\Install-SQLServerSettings.ps1) {
    Write-Host "Importing SQL Server Management Studio settings..." -ForegroundColor Cyan
    & .\sqlserver\Install-SQLServerSettings.ps1
}

# 12. Apply DSC configuration
Write-Host "Applying DSC configuration..." -ForegroundColor Cyan
. .\CompleteEnvironment.ps1
CompleteEnvironment
Start-DscConfiguration -Path .\CompleteEnvironment -Wait -Verbose -Force

# 12.1 Import IIS Websites and Application Pools
if (Test-Path .\iis\Install-IISWebsitesAndPools.ps1) {
    Write-Host "Importing IIS Websites and Application Pools..." -ForegroundColor Cyan
    & .\iis\Install-IISWebsitesAndPools.ps1
}

Write-Host "Environment setup complete!" -ForegroundColor Green
"@

$installScript | Out-File -FilePath .\Setup-NewMachine.ps1

# Create a comprehensive setup guide
$guideContent = @"
# Complete Development Environment Automation Guide

This guide helps you export your current development environment and set it up on a new machine.

## Exported Components
The export includes the following components, organized in separate folders:

- **chocolatey/** - Chocolatey packages
- **winget/** - WinGet packages (Windows Package Manager)
- **windows-features/** - Windows Features configuration
- **iis/** - IIS configuration (websites, applications, app pools, modules, handler mappings)
- **powershell/** - PowerShell modules and profiles
- **environment/** - Environment variables
- **vscode/** - Visual Studio Code extensions
- **git/** - Git configuration
- **browser-bookmarks/** - Web browser bookmarks
- **windows-terminal/** - Windows Terminal settings and profiles
- **sqlserver/** - SQL Server Management Studio and Azure Data Studio registered servers

## Steps to Export Your Current Environment

1. **Download the Required Scripts**
   Save each script below to your current machine in the same folder.

2. **Run the Export Process**
   ```powershell
   # Make sure you're running PowerShell as Administrator
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
   
   # Run the master export script
   .\Export-AllConfigurations.ps1
   ```

3. **Transfer the Export Package**
   After the export completes, you'll find a zip file named 'DevboxExport-[timestamp].zip'
   Transfer this file to your new machine.

## Steps to Import on New Machine

1. **Extract the Export Package**
   Extract the 'DevboxExport-[timestamp].zip' file to a folder on your new machine.

2. **Run the Setup Script**
   ```powershell
   # Make sure you're running PowerShell as Administrator
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
   
   # Navigate to the extracted folder
   cd path\to\extracted\folder
   
   # Run the master setup script (with default settings)
   .\Setup-NewMachine.ps1
   
   # Or customize your setup (examples):
   # - Without browser profiles:
   .\Setup-NewMachine.ps1 -ImportBrowserProfiles:$false
   
   # - Import only browser bookmarks:
   .\Setup-NewMachine.ps1 -ImportBrowserBookmarksOnly:$true
   
   # - Specify DevDrive settings:
   .\Setup-NewMachine.ps1 -DevDriveLetter "E" -DevDriveSize 100
   ```

3. **Verify the Setup**
   After the setup completes, run the validation script to check that all components were installed correctly:
   ```powershell
   .\Validate-Setup.ps1
   ```

## Manual Installation Options
If you prefer to install components individually:

1. **Install IIS websites and application pools:**
   ```powershell
   # Import only IIS websites and application pools
   .\iis\Install-IISWebsitesAndPools.ps1
   ```
"@

$guideContent | Out-File -FilePath .\SetupGuide.md

Write-Host "Setup guide has been created in 'SetupGuide.md'" -ForegroundColor Green

# 13. Create a validation script
$validationScript = @"
# Validation script to check if all components were installed correctly
Write-Host "Validating environment setup..." -ForegroundColor Cyan

# Check Windows Features
if (Test-Path .\windows-features\iis-features.json) {
    Write-Host "Validating Windows Features..." -ForegroundColor Yellow
    `$features = Get-Content .\windows-features\iis-features.json | ConvertFrom-Json
    `$allInstalled = `$true
    foreach (`$feature in `$features) {
        `$featureState = Get-WindowsOptionalFeature -Online -FeatureName `$feature.FeatureName
        if (`$featureState.State -ne "Enabled") {
            Write-Warning "Feature not installed: `$(`$feature.FeatureName)"
            `$allInstalled = `$false
        }
    }
    if (`$allInstalled) {
        Write-Host "All Windows Features are installed correctly." -ForegroundColor Green
    }
}

# Check Chocolatey packages
if (Test-Path .\chocolatey\choco-packages.txt) {
    Write-Host "Validating Chocolatey packages..." -ForegroundColor Yellow
    `$chocoPackages = Get-Content .\chocolatey\choco-packages.txt
    `$installedPackages = choco list --local-only --limit-output
    `$allInstalled = `$true
    foreach (`$package in `$chocoPackages) {
        `$pkgName = (`$package -split '\|')[0]
        if (`$installedPackages -notcontains `$package) {
            Write-Warning "Package not installed: `$pkgName"
            `$allInstalled = `$false
        }
    }
    if (`$allInstalled) {
        Write-Host "All Chocolatey packages are installed correctly." -ForegroundColor Green
    }
}

# Check PowerShell modules
if (Test-Path .\powershell\powershell-modules.json) {
    Write-Host "Validating PowerShell modules..." -ForegroundColor Yellow
    `$modules = Get-Content .\powershell\powershell-modules.json | ConvertFrom-Json
    `$allInstalled = `$true
    foreach (`$module in `$modules) {
        `$installedModule = Get-InstalledModule -Name `$module.Name -RequiredVersion `$module.Version -ErrorAction SilentlyContinue
        if (-not `$installedModule) {
            Write-Warning "Module not installed: `$(`$module.Name) v`$(`$module.Version)"
            `$allInstalled = `$false
        }
    }
    if (`$allInstalled) {
        Write-Host "All PowerShell modules are installed correctly." -ForegroundColor Green
    }
}

# Check VS Code extensions
if (Test-Path .\vscode\vscode-extensions.txt) {
    Write-Host "Validating VS Code extensions..." -ForegroundColor Yellow
    `$extensions = Get-Content .\vscode\vscode-extensions.txt
    `$installedExtensions = code --list-extensions
    `$allInstalled = `$true
    foreach (`$extension in `$extensions) {
        if (`$installedExtensions -notcontains `$extension) {
            Write-Warning "Extension not installed: `$extension"
            `$allInstalled = `$false
        }
    }
    if (`$allInstalled) {
        Write-Host "All VS Code extensions are installed correctly." -ForegroundColor Green
    }
}

# Check browser bookmarks
if (Test-Path .\browser-bookmarks) {
    Write-Host "Browser bookmarks were exported. Use the following to import them separately:" -ForegroundColor Yellow
    Write-Host "  - Import bookmarks: & '.\browser-bookmarks\Install-BrowserBookmarks.ps1'" -ForegroundColor Yellow
}

# Check Windows Terminal settings
if (Test-Path .\windows-terminal) {
    Write-Host "Windows Terminal settings were exported. Use the following to import them separately:" -ForegroundColor Yellow
    Write-Host "  - Import settings: & '.\windows-terminal\Install-WindowsTerminalSettings.ps1'" -ForegroundColor Yellow
}

# Check Oh My Posh theme
if (Test-Path .\oh-my-posh) {
    Write-Host "Oh My Posh theme was exported. Use the following to import it separately:" -ForegroundColor Yellow
    Write-Host "  - Import theme: & '.\oh-my-posh\Install-OhMyPosh.ps1'" -ForegroundColor Yellow
}

# Check IIS configuration
if (Test-Path .\iis) {
    Write-Host "IIS configuration was exported. To apply settings separately, use DSC configuration." -ForegroundColor Yellow
    
    # Check for IIS websites and application pools
    if (Test-Path .\iis\iis-websites.json -and Test-Path .\iis\iis-apppools.json) {
        Write-Host "IIS websites and application pools were exported. You can import them separately:" -ForegroundColor Yellow
        Write-Host "  - Import settings: & '.\iis\Install-IISWebsitesAndPools.ps1'" -ForegroundColor Yellow
        
        # Verify IIS websites if WebAdministration module is available
        if (Get-Module -Name WebAdministration -ListAvailable -ErrorAction SilentlyContinue) {
            Import-Module WebAdministration -ErrorAction SilentlyContinue
            $websitesJson = Get-Content -Path .\iis\iis-websites.json -Raw -ErrorAction SilentlyContinue
            $websites = ConvertFrom-Json -InputObject $websitesJson -ErrorAction SilentlyContinue
            
            if ($websites) {
                $existingCount = 0
                foreach ($site in $websites) {
                    if (Test-Path "IIS:\Sites\$($site.Name)") {
                        $existingCount++
                    }
                }
                
                Write-Host "    IIS Websites Status: $existingCount of $($websites.Count) websites installed." -ForegroundColor Green
            }
        }
    }
}

# Check Git configuration
if (Test-Path .\git) {
    Write-Host "Git configuration was exported. Use the following to import it separately:" -ForegroundColor Yellow
    Write-Host "  - Import settings: & '.\git\Install-GitConfig.ps1'" -ForegroundColor Yellow
}

# Check Environment Variables
if (Test-Path .\environment) {
    Write-Host "Environment variables were exported. Use the following to import them separately:" -ForegroundColor Yellow
    Write-Host "  - Import variables: & '.\environment\Install-EnvVariables.ps1'" -ForegroundColor Yellow
}

# Check SQL Server registered servers
if (Test-Path .\sqlserver) {
    Write-Host "SQL Server registered servers were exported. Use the following to import them separately:" -ForegroundColor Yellow
    Write-Host "  - Import SQL Server registered servers: & '.\sqlserver\Install-SQLRegisteredServers.ps1'" -ForegroundColor Yellow
    
    if (Test-Path .\sqlserver\Install-SQLServerSettings.ps1) {
        Write-Host "SQL Server Management Studio settings were exported. Use the following to import them separately:" -ForegroundColor Yellow
        Write-Host "  - Import SSMS settings: & '.\sqlserver\Install-SQLServerSettings.ps1'" -ForegroundColor Yellow
        Write-Host "  - Import SSMS settings (manual instructions only): & '.\sqlserver\Install-SQLServerSettings.ps1 -ManualInstructionsOnly'" -ForegroundColor Yellow
    }
}

Write-Host "Validation complete!" -ForegroundColor Cyan
"@

$validationScript | Out-File -FilePath .\Validate-Setup.ps1

# 14. Package everything into a single zip file for easy transfer
Write-Host "Creating export package..." -ForegroundColor Cyan
Set-Location ..
$zipFilePath = ".\$exportDir.zip"
if (Get-Command Compress-Archive -ErrorAction SilentlyContinue) {
    Compress-Archive -Path $exportDir -DestinationPath $zipFilePath -Force
} else {
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::CreateFromDirectory($exportDir, $zipFilePath)
}

Write-Host "All configuration export completed successfully!" -ForegroundColor Green
Write-Host "Export package created at: $zipFilePath" -ForegroundColor Green
Write-Host "To set up a new machine, copy this zip file and follow the instructions in 'SetupGuide.md'" -ForegroundColor Green