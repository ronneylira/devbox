# Export Browser Profiles

function Export-BrowserProfiles {
    [CmdletBinding()]
    param (
        [string]$ExportPath = ".\browser-profiles"
    )
    
    Write-Host "Exporting browser profiles and bookmarks..." -ForegroundColor Cyan
    
    # Create export directory
    if (-not (Test-Path $ExportPath)) {
        New-Item -ItemType Directory -Path $ExportPath -Force | Out-Null
    }
    
    # Chrome profiles
    $chromeProfilesPath = "$env:LOCALAPPDATA\Google\Chrome\User Data"
    $chromeProfilesToExport = @("Default", "Profile 1", "Profile 2")
    $chromePaths = @{
        Bookmarks = "Bookmarks"
        Preferences = "Preferences" 
        Extensions = "Extensions"
        Cookies = "Network\Cookies"
    }
    
    # Edge profiles
    $edgeProfilesPath = "$env:LOCALAPPDATA\Microsoft\Edge\User Data"
    $edgeProfilesToExport = @("Default", "Profile 1", "Profile 2")
    $edgePaths = @{
        Bookmarks = "Bookmarks"
        Preferences = "Preferences"
        Extensions = "Extensions"
        Cookies = "Network\Cookies"
    }
    
    # Firefox profiles
    $firefoxProfilesPath = "$env:APPDATA\Mozilla\Firefox\Profiles"
    
    # Export profiles function
    function Export-ProfileData {
        param (
            [string]$BrowserName,
            [string]$ProfilesPath,
            [array]$ProfilesToExport,
            [hashtable]$PathsToExport
        )
        
        if (Test-Path $ProfilesPath) {
            Write-Host "Exporting $BrowserName profiles..."
            
            # Create browser export directory
            $browserExportPath = Join-Path $ExportPath $BrowserName
            if (-not (Test-Path $browserExportPath)) {
                New-Item -ItemType Directory -Path $browserExportPath -Force | Out-Null
            }
            
            foreach ($profile in $ProfilesToExport) {
                $profilePath = Join-Path $ProfilesPath $profile
                if (Test-Path $profilePath) {
                    Write-Host "  - Exporting $profile profile..."
                    
                    # Create profile export directory
                    $profileExportPath = Join-Path $browserExportPath $profile
                    if (-not (Test-Path $profileExportPath)) {
                        New-Item -ItemType Directory -Path $profileExportPath -Force | Out-Null
                    }
                    
                    # Export specific profile data
                    foreach ($key in $PathsToExport.Keys) {
                        $dataPath = Join-Path $profilePath $PathsToExport[$key]
                        if (Test-Path $dataPath) {
                            try {
                                $targetPath = Join-Path $profileExportPath $key
                                if (Test-Path $dataPath -PathType Leaf) {
                                    Copy-Item -Path $dataPath -Destination $targetPath -Force
                                } else {
                                    Copy-Item -Path $dataPath -Destination $targetPath -Recurse -Force -ErrorAction SilentlyContinue
                                }
                                Write-Host "    - Exported $key"
                            } catch {
                                Write-Warning "    - Failed to export $key: ${_}"
                            }
                        }
                    }
                }
            }
        } else {
            Write-Host "$BrowserName not found on this machine." -ForegroundColor Yellow
        }
    }
    
    # Export Firefox profiles
    if (Test-Path $firefoxProfilesPath) {
        Write-Host "Exporting Firefox profiles..."
        
        # Create Firefox export directory
        $firefoxExportPath = Join-Path $ExportPath "Firefox"
        if (-not (Test-Path $firefoxExportPath)) {
            New-Item -ItemType Directory -Path $firefoxExportPath -Force | Out-Null
        }
        
        # Get all Firefox profiles
        $firefoxProfiles = Get-ChildItem -Path $firefoxProfilesPath -Directory
        
        foreach ($profile in $firefoxProfiles) {
            Write-Host "  - Exporting $($profile.Name) profile..."
            
            # Create profile export directory
            $profileExportPath = Join-Path $firefoxExportPath $profile.Name
            if (-not (Test-Path $profileExportPath)) {
                New-Item -ItemType Directory -Path $profileExportPath -Force | Out-Null
            }
            
            # Export bookmarks
            $bookmarksPath = Join-Path $profile.FullName "places.sqlite"
            if (Test-Path $bookmarksPath) {
                try {
                    Copy-Item -Path $bookmarksPath -Destination (Join-Path $profileExportPath "places.sqlite") -Force
                    Write-Host "    - Exported bookmarks"
                } catch {
                    Write-Warning "    - Failed to export bookmarks: $_"
                }
            }
            
            # Export preferences
            $prefsPath = Join-Path $profile.FullName "prefs.js"
            if (Test-Path $prefsPath) {
                try {
                    Copy-Item -Path $prefsPath -Destination (Join-Path $profileExportPath "prefs.js") -Force
                    Write-Host "    - Exported preferences"
                } catch {
                    Write-Warning "    - Failed to export preferences: $_"
                }
            }
            
            # Export extensions
            $extensionsPath = Join-Path $profile.FullName "extensions"
            if (Test-Path $extensionsPath) {
                try {
                    Copy-Item -Path $extensionsPath -Destination (Join-Path $profileExportPath "extensions") -Recurse -Force -ErrorAction SilentlyContinue
                    Write-Host "    - Exported extensions"
                } catch {
                    Write-Warning "    - Failed to export extensions: $_"
                }
            }
        }
    } else {
        Write-Host "Firefox not found on this machine." -ForegroundColor Yellow
    }
    
    # Export Chrome profiles
    Export-ProfileData -BrowserName "Chrome" -ProfilesPath $chromeProfilesPath -ProfilesToExport $chromeProfilesToExport -PathsToExport $chromePaths
    
    # Export Edge profiles
    Export-ProfileData -BrowserName "Edge" -ProfilesPath $edgeProfilesPath -ProfilesToExport $edgeProfilesToExport -PathsToExport $edgePaths
    
    # Create installation script
    $installScript = @"
# Browser Profiles Installation Script
[CmdletBinding()]
param(
    [switch]\$ImportBookmarksOnly = \$false
)

Write-Host "Installing browser profiles and bookmarks..." -ForegroundColor Cyan

# Chrome profiles
\$chromeProfilesPath = "\$env:LOCALAPPDATA\Google\Chrome\User Data"
\$chromeProfilesToImport = @("Default", "Profile 1", "Profile 2")
\$chromePaths = @{
    Bookmarks = "Bookmarks"
    Preferences = "Preferences" 
    Extensions = "Extensions"
    Cookies = "Network\Cookies"
}

# Edge profiles
\$edgeProfilesPath = "\$env:LOCALAPPDATA\Microsoft\Edge\User Data"
\$edgeProfilesToImport = @("Default", "Profile 1", "Profile 2")
\$edgePaths = @{
    Bookmarks = "Bookmarks"
    Preferences = "Preferences"
    Extensions = "Extensions"
    Cookies = "Network\Cookies"
}

# Firefox profiles
\$firefoxProfilesPath = "\$env:APPDATA\Mozilla\Firefox\Profiles"

# Import profiles function
function Import-ProfileData {
    param (
        [string]\$BrowserName,
        [string]\$ProfilesPath,
        [array]\$ProfilesToImport,
        [hashtable]\$PathsToImport,
        [bool]\$BookmarksOnly
    )
    
    \$browserExportPath = Join-Path ".\browser-profiles" \$BrowserName
    if (Test-Path \$browserExportPath) {
        Write-Host "Importing \$BrowserName profiles..."
        
        # Make sure browser is not running
        \$processes = Get-Process -Name \$BrowserName -ErrorAction SilentlyContinue
        if (\$processes) {
            Write-Warning "\$BrowserName is currently running. Please close it before importing profiles."
            return
        }
        
        # Create browser profiles directory if it doesn't exist
        if (-not (Test-Path \$ProfilesPath)) {
            New-Item -ItemType Directory -Path \$ProfilesPath -Force | Out-Null
        }
        
        foreach (\$profile in \$ProfilesToImport) {
            \$profileExportPath = Join-Path \$browserExportPath \$profile
            if (Test-Path \$profileExportPath) {
                Write-Host "  - Importing \$profile profile..."
                
                # Create profile directory if it doesn't exist
                \$profilePath = Join-Path \$ProfilesPath \$profile
                if (-not (Test-Path \$profilePath)) {
                    New-Item -ItemType Directory -Path \$profilePath -Force | Out-Null
                }
                
                # Import specific profile data
                foreach (\$key in \$PathsToImport.Keys) {
                    # Skip non-bookmark data if bookmarks-only mode is enabled
                    if (\$BookmarksOnly -and \$key -ne "Bookmarks") {
                        continue
                    }
                    
                    \$sourcePath = Join-Path \$profileExportPath \$key
                    if (Test-Path \$sourcePath) {
                        try {
                            \$targetPath = Join-Path \$profilePath \$PathsToImport[\$key]
                            \$targetDir = Split-Path \$targetPath -Parent
                            
                            # Create parent directory if it doesn't exist
                            if (-not (Test-Path \$targetDir)) {
                                New-Item -ItemType Directory -Path \$targetDir -Force | Out-Null
                            }
                            
                            if (Test-Path \$sourcePath -PathType Leaf) {
                                Copy-Item -Path \$sourcePath -Destination \$targetPath -Force
                            } else {
                                Copy-Item -Path \$sourcePath -Destination \$targetDir -Recurse -Force -ErrorAction SilentlyContinue
                            }
                            Write-Host "    - Imported \$key"
                        } catch {
                            Write-Warning "    - Failed to import \$key: \${_}"
                        }
                    }
                }
            }
        }
    } else {
        Write-Host "\$BrowserName profiles not found in the export." -ForegroundColor Yellow
    }
}

# Import Firefox profiles
\$firefoxExportPath = Join-Path ".\browser-profiles" "Firefox"
if (Test-Path \$firefoxExportPath) {
    Write-Host "Importing Firefox profiles..."
    
    # Make sure Firefox is not running
    \$firefoxProcesses = Get-Process -Name firefox -ErrorAction SilentlyContinue
    if (\$firefoxProcesses) {
        Write-Warning "Firefox is currently running. Please close it before importing profiles."
    } else {
        # Create Firefox profiles directory if it doesn't exist
        if (-not (Test-Path \$firefoxProfilesPath)) {
            New-Item -ItemType Directory -Path \$firefoxProfilesPath -Force | Out-Null
        }
        
        # Get all exported Firefox profiles
        \$exportedProfiles = Get-ChildItem -Path \$firefoxExportPath -Directory
        
        foreach (\$profile in \$exportedProfiles) {
            Write-Host "  - Importing \$(\$profile.Name) profile..."
            
            # Create profile directory if it doesn't exist
            \$profilePath = Join-Path \$firefoxProfilesPath \$profile.Name
            if (-not (Test-Path \$profilePath)) {
                New-Item -ItemType Directory -Path \$profilePath -Force | Out-Null
            }
            
            # Import bookmarks
            \$bookmarksPath = Join-Path \$profile.FullName "places.sqlite"
            if (Test-Path \$bookmarksPath) {
                try {
                    Copy-Item -Path \$bookmarksPath -Destination (Join-Path \$profilePath "places.sqlite") -Force
                    Write-Host "    - Imported bookmarks"
                } catch {
                    Write-Warning "    - Failed to import bookmarks: \${_}"
                }
            }
            
            # Import other data if not in bookmarks-only mode
            if (-not \$ImportBookmarksOnly) {
                # Import preferences
                \$prefsPath = Join-Path \$profile.FullName "prefs.js"
                if (Test-Path \$prefsPath) {
                    try {
                        Copy-Item -Path \$prefsPath -Destination (Join-Path \$profilePath "prefs.js") -Force
                        Write-Host "    - Imported preferences"
                    } catch {
                        Write-Warning "    - Failed to import preferences: \${_}"
                    }
                }
                
                # Import extensions
                \$extensionsPath = Join-Path \$profile.FullName "extensions"
                if (Test-Path \$extensionsPath) {
                    try {
                        Copy-Item -Path \$extensionsPath -Destination (Join-Path \$profilePath "extensions") -Recurse -Force -ErrorAction SilentlyContinue
                        Write-Host "    - Imported extensions"
                    } catch {
                        Write-Warning "    - Failed to import extensions: \${_}"
                    }
                }
            }
        }
    }
} else {
    Write-Host "Firefox profiles not found in the export." -ForegroundColor Yellow
}

# Import Chrome profiles
Import-ProfileData -BrowserName "Chrome" -ProfilesPath \$chromeProfilesPath -ProfilesToImport \$chromeProfilesToImport -PathsToImport \$chromePaths -BookmarksOnly \$ImportBookmarksOnly

# Import Edge profiles
Import-ProfileData -BrowserName "Edge" -ProfilesPath \$edgeProfilesPath -ProfilesToImport \$edgeProfilesToImport -PathsToImport \$edgePaths -BookmarksOnly \$ImportBookmarksOnly

Write-Host "Browser profiles import complete." -ForegroundColor Green
"@
    
    $installScript | Out-File -FilePath "$ExportPath\Install-BrowserProfiles.ps1"
    Write-Host "Browser profiles export complete. Installation script created at $ExportPath\Install-BrowserProfiles.ps1" -ForegroundColor Green
}

# Execute the function
Export-BrowserProfiles 