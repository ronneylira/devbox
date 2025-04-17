# Export Oh My Posh theme and configuration

[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [string]$ExportPath = "."
)

function Test-OhMyPoshInstalled {
    try {
        $null = Get-Command oh-my-posh -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

function Get-OhMyPoshThemePath {
    # Check if the theme is referenced in PowerShell profile
    if (Test-Path -Path $PROFILE) {
        $profileContent = Get-Content -Path $PROFILE -Raw
        $themeMatch = $profileContent | Select-String -Pattern 'oh-my-posh\s+(?:init|--config)\s+(?:pwsh\s+--config\s+)?([^\s|]+)' -AllMatches
        
        if ($themeMatch.Matches.Count -gt 0 -and $themeMatch.Matches[0].Groups.Count -gt 1) {
            $themePath = $themeMatch.Matches[0].Groups[1].Value
            $themePath = $themePath -replace '~', $HOME
            
            if (Test-Path -Path $themePath) {
                Write-Host "Found theme in profile: $themePath" -ForegroundColor Green
                return $themePath
            }
        }
    }
    
    # Check if POSH_THEMES_PATH environment variable is set
    if ($env:POSH_THEMES_PATH -and (Test-Path -Path $env:POSH_THEMES_PATH)) {
        $themeFiles = Get-ChildItem -Path $env:POSH_THEMES_PATH -Filter "*.omp.json"
        if ($themeFiles.Count -gt 0) {
            # If multiple themes exist, try to find the active one
            # by checking the profile or using the first one as fallback
            Write-Host "Found theme in POSH_THEMES_PATH: $($themeFiles[0].FullName)" -ForegroundColor Green
            return $themeFiles[0].FullName
        }
    }
    
    # Check common locations
    $commonLocations = @(
        "$HOME\.poshthemes",
        "$HOME\AppData\Local\Programs\oh-my-posh\themes",
        "$env:LOCALAPPDATA\Programs\oh-my-posh\themes"
    )
    
    foreach ($location in $commonLocations) {
        if (Test-Path -Path $location) {
            Write-Host "Checking location: $location" -ForegroundColor Yellow
            $themeFiles = Get-ChildItem -Path $location -Filter "*.omp.json" -Recurse
            if ($themeFiles.Count -gt 0) {
                Write-Host "Found theme in common location: $($themeFiles[0].FullName)" -ForegroundColor Green
                return $themeFiles[0].FullName
            }
        }
    }
    
    return $null
}

function Export-OhMyPoshTheme {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ThemePath,
        [Parameter(Mandatory = $true)]
        [string]$ExportPath
    )
    
    try {
        $themeName = (Get-Item -Path $ThemePath).Name
        $destPath = Join-Path -Path $ExportPath -ChildPath $themeName
        Copy-Item -Path $ThemePath -Destination $destPath -Force
        
        Write-Host "Oh My Posh theme exported: $destPath" -ForegroundColor Green
        
        # Create an import script
        $importScriptPath = Join-Path -Path $ExportPath -ChildPath "Install-OhMyPosh.ps1"
        $importContent = @"
# Install and configure Oh My Posh theme
# Run this script to set up Oh My Posh with the exported theme

# Check if Oh My Posh is installed, install if needed
if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Oh My Posh..." -ForegroundColor Yellow
    winget install JanDeDobbeleer.OhMyPosh -s winget
    # Alternatively: Install-Module oh-my-posh -Scope CurrentUser -Force
}

# Create themes directory if it doesn't exist
`$themesDir = "`$HOME\.poshthemes"
if (-not (Test-Path -Path `$themesDir)) {
    New-Item -Path `$themesDir -ItemType Directory -Force | Out-Null
}

# Copy theme file to themes directory
`$sourceTheme = Join-Path -Path `$PSScriptRoot -ChildPath "$themeName"
`$destTheme = Join-Path -Path `$themesDir -ChildPath "$themeName"
Copy-Item -Path `$sourceTheme -Destination `$destTheme -Force

# Add oh-my-posh initialization to PowerShell profile if not already present
`$profileContent = ""
if (Test-Path -Path `$PROFILE) {
    `$profileContent = Get-Content -Path `$PROFILE -Raw
}

`$initStatement = "oh-my-posh init pwsh --config `$destTheme | Invoke-Expression"
if (`$profileContent -notmatch "oh-my-posh init") {
    Add-Content -Path `$PROFILE -Value "`n# Initialize Oh My Posh with custom theme"
    Add-Content -Path `$PROFILE -Value `$initStatement
    Write-Host "Added Oh My Posh initialization to your PowerShell profile." -ForegroundColor Green
}
else {
    Write-Host "Your PowerShell profile already contains Oh My Posh initialization." -ForegroundColor Yellow
    Write-Host "You may want to update it manually to use the new theme path:" -ForegroundColor Yellow
    Write-Host `$initStatement -ForegroundColor Cyan
}

Write-Host "Oh My Posh theme installation complete. Please restart your terminal or run: " -ForegroundColor Green
Write-Host "  . `$PROFILE" -ForegroundColor Cyan
Write-Host "to apply the changes." -ForegroundColor Green
"@
        
        Set-Content -Path $importScriptPath -Value $importContent -Force
        Write-Host "Oh My Posh theme installation script created: $importScriptPath" -ForegroundColor Green
        
        return $true
    }
    catch {
        Write-Error "Error exporting Oh My Posh theme: $_"
        return $false
    }
}

# Main script execution
Write-Host "Starting Oh My Posh theme export to $ExportPath" -ForegroundColor Cyan

if (-not (Test-Path -Path $ExportPath)) {
    New-Item -Path $ExportPath -ItemType Directory -Force | Out-Null
    Write-Host "Created export directory: $ExportPath" -ForegroundColor Green
}

if (Test-OhMyPoshInstalled) {
    Write-Host "Oh My Posh is installed. Exporting theme configuration..." -ForegroundColor Green
    $themePath = Get-OhMyPoshThemePath
    
    if ($themePath) {
        Export-OhMyPoshTheme -ThemePath $themePath -ExportPath $ExportPath
    }
    else {
        # If we can't find a theme but Oh My Posh is installed, create a basic theme file
        Write-Warning "Could not find an Oh My Posh theme configuration. Creating a default theme."
        $defaultTheme = @"
{
  "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
  "blocks": [
    {
      "type": "prompt",
      "alignment": "left",
      "segments": [
        {
          "type": "path",
          "style": "powerline",
          "powerline_symbol": "\uE0B0",
          "foreground": "#ffffff",
          "background": "#0077c2",
          "properties": {
            "prefix": " \uE5FF ",
            "style": "folder"
          }
        },
        {
          "type": "git",
          "style": "powerline",
          "powerline_symbol": "\uE0B0",
          "foreground": "#193549",
          "background": "#ffeb3b",
          "properties": {
            "display_stash_count": true,
            "display_upstream_icon": true
          }
        },
        {
          "type": "exit",
          "style": "powerline",
          "powerline_symbol": "\uE0B0",
          "foreground": "#ffffff",
          "background": "#ff5252",
          "properties": {
            "display_exit_code": false,
            "always_enabled": false,
            "error_color": "#ff5252",
            "prefix": " \uE20F"
          }
        }
      ]
    },
    {
      "type": "prompt",
      "alignment": "left",
      "newline": true,
      "segments": [
        {
          "type": "text",
          "style": "plain",
          "foreground": "#007ACC",
          "properties": {
            "prefix": "",
            "text": "\u276F"
          }
        }
      ]
    }
  ]
}
"@
        $defaultThemePath = Join-Path -Path $ExportPath -ChildPath "devbox-default.omp.json"
        Set-Content -Path $defaultThemePath -Value $defaultTheme
        Write-Host "Created default theme at: $defaultThemePath" -ForegroundColor Green
        Export-OhMyPoshTheme -ThemePath $defaultThemePath -ExportPath $ExportPath
    }
}
else {
    Write-Warning "Oh My Posh is not installed on this system. Creating install script only."
    
    # Create just the installation script without a theme
    $importScriptPath = Join-Path -Path $ExportPath -ChildPath "Install-OhMyPosh.ps1"
    $importContent = @"
# Install and configure Oh My Posh
# Run this script to set up Oh My Posh

# Check if Oh My Posh is installed, install if needed
if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Oh My Posh..." -ForegroundColor Yellow
    winget install JanDeDobbeleer.OhMyPosh -s winget
    # Alternatively: Install-Module oh-my-posh -Scope CurrentUser -Force
}

# Initialize with a default theme
Write-Host "Setting up Oh My Posh with default theme..." -ForegroundColor Green
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression

# Add to profile
`$profileContent = ""
if (Test-Path -Path `$PROFILE) {
    `$profileContent = Get-Content -Path `$PROFILE -Raw
}

`$initStatement = "oh-my-posh init pwsh --config `$env:POSH_THEMES_PATH\paradox.omp.json | Invoke-Expression"
if (`$profileContent -notmatch "oh-my-posh init") {
    Add-Content -Path `$PROFILE -Value "`n# Initialize Oh My Posh"
    Add-Content -Path `$PROFILE -Value `$initStatement
    Write-Host "Added Oh My Posh initialization to your PowerShell profile." -ForegroundColor Green
}

Write-Host "Oh My Posh installation complete. Please restart your terminal or run: " -ForegroundColor Green
Write-Host "  . `$PROFILE" -ForegroundColor Cyan
Write-Host "to apply the changes." -ForegroundColor Green
"@
    
    Set-Content -Path $importScriptPath -Value $importContent -Force
    Write-Host "Oh My Posh installation script created: $importScriptPath" -ForegroundColor Green
} 