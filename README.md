# DevBox Migration Toolkit

A comprehensive PowerShell-based toolkit for exporting and migrating your entire development environment configuration between machines.

## Overview

This toolkit provides a set of PowerShell scripts to automate the tedious process of setting up a new development machine. It captures your current configuration and creates installation scripts that can be run on a new machine to recreate your environment.

## Features

- **Modular Design**: Each component is exported to its own directory for better organization
- **Comprehensive Coverage**: Captures all aspects of your development environment
- **Automated Setup**: One-click setup on new machines with the generated installation scripts
- **Validation**: Includes validation scripts to ensure everything was installed correctly

## What Gets Exported

| Component | Description |
|-----------|-------------|
| 🍫 Chocolatey Packages | All installed Chocolatey packages |
| 📦 WinGet Packages | Windows Package Manager packages |
| 🪟 Windows Features | Installed Windows features including IIS |
| 🌐 IIS Configuration | Websites, applications, app pools, and configuration |
| 💻 PowerShell | Modules and profiles |
| 🔑 Environment Variables | User and system environment variables |
| 📝 VS Code | Extensions and settings |
| 🔄 Git | Git configuration |
| 🔖 Browser Bookmarks | Chrome, Edge, and Firefox bookmarks |
| 🖥️ Windows Terminal | Terminal settings and profiles |
| 💎 Oh My Posh | Terminal themes and configuration |
| 🧰 SQL Server | Configuration settings |

## Getting Started

### Prerequisites

- Windows 10/11 or Windows Server
- PowerShell 5.1+ (PowerShell 7 recommended)
- Administrative privileges

### Export Your Environment

```powershell
# Run as Administrator
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
.\Export-AllConfigurations.ps1
```

This will create a directory named `DevboxExport-[timestamp]` containing all your exported configurations and a zip file for easy transfer.

### Import on a New Machine

1. Copy the generated ZIP file to your new machine
2. Extract the contents
3. Run as Administrator:

```powershell
# Run as Administrator
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
.\Setup-NewMachine.ps1
```

### Customization Options

The setup script supports several parameters:

```powershell
.\Setup-NewMachine.ps1 -CreateDevDrive $true -DevDriveLetter "D" -DevDriveSize 80
```

| Parameter | Description | Default |
|-----------|-------------|---------|
| `-CreateDevDrive` | Whether to create a DevDrive | `$true` |
| `-DevDriveLetter` | Drive letter for DevDrive | `"D"` |
| `-DevDriveSize` | Size of DevDrive in GB | `80` |
| `-ImportBrowserProfiles` | Whether to import browser profiles | `$true` |
| `-ImportBrowserBookmarksOnly` | Import only bookmarks, not entire profiles | `$false` |
| `-SetupOhMyPosh` | Install and configure Oh-My-Posh | `$true` |

## Validation

After importing, run the validation script to ensure everything was set up correctly:

```powershell
.\Validate-Setup.ps1
```

## Component Scripts

- `Export-AllConfigurations.ps1` - Main export script
- `Export-EnvVariables.ps1` - Environment variables export
- `Export-IISConfig.ps1` - IIS configuration export
- `Export-IISModules.ps1` - IIS modules export
- `Export-OhMyPoshTheme.ps1` - Oh My Posh theme export
- `Export-PSModules.ps1` - PowerShell modules export
- `Export-PSProfiles.ps1` - PowerShell profiles export
- `Export-SimpleBrowserProfiles.ps1` - Browser profiles export
- `Export-WindowsFeatures.ps1` - Windows features export
- `Export-WindowsTerminalSettings.ps1` - Windows Terminal settings export
- `Generate-IISDscConfig.ps1` - IIS DSC configuration generator
- `Setup-DevDrive.ps1` - Creates development drive

## License

MIT

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. 