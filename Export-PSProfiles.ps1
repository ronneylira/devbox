# Export PowerShell profiles

function Export-PowerShellProfiles {
  Write-Host "Exporting PowerShell profiles..."
  
  # Define profile paths to check
  $profilePaths = @(
      # Windows PowerShell profiles
      $PROFILE.CurrentUserAllHosts,            # Windows PowerShell profile for current user
      $PROFILE.CurrentUserCurrentHost,         # Windows PowerShell console profile for current user
      $PROFILE.AllUsersAllHosts,               # Windows PowerShell profile for all users
      $PROFILE.AllUsersCurrentHost,            # Windows PowerShell console profile for all users
      
      # PowerShell Core profiles (if exists)
      "$HOME\Documents\PowerShell\profile.ps1",
      "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1",
      "$HOME\Documents\PowerShell\Microsoft.VSCode_profile.ps1",
      
      # VS Code PowerShell profile (if exists)
      "$HOME\Documents\WindowsPowerShell\Microsoft.VSCode_profile.ps1"
  )
  
  # Create profiles directory if it doesn't exist
  if (-not (Test-Path .\profiles)) {
      New-Item -ItemType Directory -Path .\profiles | Out-Null
  }
  
  # Export each profile if it exists
  $exportedProfiles = @()
  foreach ($profilePath in $profilePaths) {
      $expandedPath = [System.Environment]::ExpandEnvironmentVariables($profilePath)
      if (Test-Path $expandedPath) {
          $profileName = (Split-Path $expandedPath -Leaf)
          Write-Host "Found profile: $profileName"
          Copy-Item -Path $expandedPath -Destination ".\profiles\$profileName"
          $exportedProfiles += @{
              OriginalPath = $expandedPath
              ProfileName = $profileName
          }
      }
  }
  
  # Export profile paths data
  $exportedProfiles | ConvertTo-Json | Out-File -FilePath .\profiles\profile-paths.json
  
  # Create installation script for profiles
  $installScript = @"
# PowerShell Profiles Installation Script
Write-Host "Installing PowerShell profiles..." -ForegroundColor Cyan

# Read profile paths data
$profilesData = Get-Content .\profiles\profile-paths.json | ConvertFrom-Json

foreach ($profile in $profilesData) {
  $targetPath = [System.Environment]::ExpandEnvironmentVariables($profile.OriginalPath)
  $targetDir = Split-Path $targetPath -Parent
  
  # Create directory if it doesn't exist
  if (-not (Test-Path $targetDir)) {
      Write-Host "Creating directory: $targetDir"
      New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
  }
  
  # Copy profile
  Write-Host "Copying profile to $targetPath"
  Copy-Item -Path ".\profiles\$($profile.ProfileName)" -Destination $targetPath -Force
}

Write-Host "PowerShell profiles installation complete."
"@
  
  $installScript | Out-File -FilePath .\Install-PSProfiles.ps1
  Write-Host "PowerShell profiles export complete. Installation script created at .\Install-PSProfiles.ps1"
}

# Execute the function
Export-PowerShellProfiles