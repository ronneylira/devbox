# Export Browser Bookmarks Only
# This is a simplified version that only exports browser bookmarks

function Export-BrowserBookmarks {
    [CmdletBinding()]
    param (
        [string]$ExportPath = ".\browser-bookmarks"
    )
    
    Write-Host "Exporting browser bookmarks..." -ForegroundColor Cyan
    
    # Create export directory
    if (-not (Test-Path $ExportPath)) {
        New-Item -ItemType Directory -Path $ExportPath -Force | Out-Null
    }
    
    # Chrome bookmarks
    $chromeBookmarksPath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Bookmarks"
    if (Test-Path $chromeBookmarksPath) {
        try {
            Copy-Item -Path $chromeBookmarksPath -Destination "$ExportPath\Chrome-Bookmarks" -Force
            Write-Host "Exported Chrome bookmarks" -ForegroundColor Green
        } catch {
            $errorMsg = $_.Exception.Message
            Write-Warning "Failed to export Chrome bookmarks: $errorMsg"
        }
    } else {
        Write-Host "Chrome bookmarks not found" -ForegroundColor Yellow
    }
    
    # Edge bookmarks
    $edgeBookmarksPath = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Bookmarks"
    if (Test-Path $edgeBookmarksPath) {
        try {
            Copy-Item -Path $edgeBookmarksPath -Destination "$ExportPath\Edge-Bookmarks" -Force
            Write-Host "Exported Edge bookmarks" -ForegroundColor Green
        } catch {
            $errorMsg = $_.Exception.Message
            Write-Warning "Failed to export Edge bookmarks: $errorMsg"
        }
    } else {
        Write-Host "Edge bookmarks not found" -ForegroundColor Yellow
    }
    
    # Firefox bookmarks (places.sqlite)
    $firefoxProfilesPath = "$env:APPDATA\Mozilla\Firefox\Profiles"
    if (Test-Path $firefoxProfilesPath) {
        $firefoxProfiles = Get-ChildItem -Path $firefoxProfilesPath -Directory
        
        foreach ($profile in $firefoxProfiles) {
            $placesPath = Join-Path $profile.FullName "places.sqlite"
            if (Test-Path $placesPath) {
                try {
                    Copy-Item -Path $placesPath -Destination "$ExportPath\Firefox-$($profile.Name)-places.sqlite" -Force
                    Write-Host "Exported Firefox bookmarks from profile $($profile.Name)" -ForegroundColor Green
                } catch {
                    $errorMsg = $_.Exception.Message
                    Write-Warning "Failed to export Firefox bookmarks from profile $($profile.Name): $errorMsg"
                }
            }
        }
    } else {
        Write-Host "Firefox profiles not found" -ForegroundColor Yellow
    }
    
    # Create installation script
    $installContent = @'
# Browser Bookmarks Installation Script
param(
    [string]$SourcePath = ".\browser-bookmarks"
)

Write-Host "Installing browser bookmarks..." -ForegroundColor Cyan

# Chrome bookmarks
$chromeBookmarksFile = "$SourcePath\Chrome-Bookmarks"
if (Test-Path $chromeBookmarksFile) {
    $chromeBookmarksTarget = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Bookmarks"
    $chromeDir = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default"
    
    if (-not (Test-Path $chromeDir)) {
        New-Item -ItemType Directory -Path $chromeDir -Force | Out-Null
    }
    
    try {
        Copy-Item -Path $chromeBookmarksFile -Destination $chromeBookmarksTarget -Force
        Write-Host "Chrome bookmarks installed" -ForegroundColor Green
    } catch {
        $errorMsg = $_.Exception.Message
        Write-Warning "Failed to install Chrome bookmarks: $errorMsg"
    }
} else {
    Write-Host "Chrome bookmarks not found in export" -ForegroundColor Yellow
}

# Edge bookmarks
$edgeBookmarksFile = "$SourcePath\Edge-Bookmarks"
if (Test-Path $edgeBookmarksFile) {
    $edgeBookmarksTarget = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Bookmarks"
    $edgeDir = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default"
    
    if (-not (Test-Path $edgeDir)) {
        New-Item -ItemType Directory -Path $edgeDir -Force | Out-Null
    }
    
    try {
        Copy-Item -Path $edgeBookmarksFile -Destination $edgeBookmarksTarget -Force
        Write-Host "Edge bookmarks installed" -ForegroundColor Green
    } catch {
        $errorMsg = $_.Exception.Message
        Write-Warning "Failed to install Edge bookmarks: $errorMsg"
    }
} else {
    Write-Host "Edge bookmarks not found in export" -ForegroundColor Yellow
}

# Firefox bookmarks
$firefoxFiles = Get-ChildItem -Path $SourcePath -Filter "Firefox-*-places.sqlite"
if ($firefoxFiles.Count -gt 0) {
    $firefoxProfilesPath = "$env:APPDATA\Mozilla\Firefox\Profiles"
    
    if (-not (Test-Path $firefoxProfilesPath)) {
        New-Item -ItemType Directory -Path $firefoxProfilesPath -Force | Out-Null
        Write-Warning "Firefox profiles directory created, but profiles need to be set up before importing bookmarks"
    } else {
        $profiles = Get-ChildItem -Path $firefoxProfilesPath -Directory
        
        foreach ($file in $firefoxFiles) {
            $profileName = ($file.Name -replace "Firefox-", "" -replace "-places.sqlite", "")
            
            # Try to find matching profile
            $matchingProfile = $profiles | Where-Object { $_.Name -eq $profileName }
            
            if ($matchingProfile) {
                try {
                    # Close Firefox first
                    $firefoxProcesses = Get-Process -Name firefox -ErrorAction SilentlyContinue
                    if ($firefoxProcesses) {
                        Write-Warning "Please close Firefox before importing bookmarks"
                    } else {
                        $targetFile = Join-Path $matchingProfile.FullName "places.sqlite"
                        Copy-Item -Path $file.FullName -Destination $targetFile -Force
                        Write-Host "Firefox bookmarks installed for profile $profileName" -ForegroundColor Green
                    }
                } catch {
                    $errorMsg = $_.Exception.Message
                    Write-Warning "Failed to install Firefox bookmarks for profile $profileName: $errorMsg"
                }
            } else {
                Write-Warning "Firefox profile $profileName not found on this machine"
            }
        }
    }
} else {
    Write-Host "Firefox bookmarks not found in export" -ForegroundColor Yellow
}

Write-Host "Browser bookmarks installation complete" -ForegroundColor Cyan
'@
    
    # Save the install script
    $installContent | Out-File -FilePath "$ExportPath\Install-BrowserBookmarks.ps1" -Encoding utf8
    
    Write-Host "Browser bookmarks export complete!" -ForegroundColor Green
    Write-Host "Installation script created at: $ExportPath\Install-BrowserBookmarks.ps1" -ForegroundColor Green
}

# Execute the function
Export-BrowserBookmarks 