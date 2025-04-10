# Export PowerShell modules

function Export-PowerShellModules {
  Write-Host "Exporting PowerShell modules..."
  
  # Get all installed modules
  $modules = Get-InstalledModule
  
  # Export module details
  $modulesExport = $modules | Select-Object Name, Version, Repository
  $modulesExport | ConvertTo-Json | Out-File -FilePath .\powershell-modules.json
  
  # Create installation script
  $installScript = @"
# PowerShell Module Installation Script
Write-Host "Installing PowerShell modules..." -ForegroundColor Cyan

# Make sure PSGallery is trusted
if ((Get-PSRepository -Name PSGallery).InstallationPolicy -ne 'Trusted') {
  Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
}

"@
  
  foreach ($module in $modules) {
      $installScript += @"
# Install $($module.Name) v$($module.Version)
Write-Host "Installing $($module.Name)..."
if (-not (Get-InstalledModule -Name "$($module.Name)" -RequiredVersion "$($module.Version)" -ErrorAction SilentlyContinue)) {
  Install-Module -Name "$($module.Name)" -RequiredVersion "$($module.Version)" -Force
}

"@
  }
  
  $installScript | Out-File -FilePath .\Install-PSModules.ps1
  Write-Host "PowerShell modules export complete. Installation script created at .\Install-PSModules.ps1"
}

# Execute the function
Export-PowerShellModules