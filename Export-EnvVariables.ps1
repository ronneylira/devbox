# Export environment variables (both user and system)

function Export-EnvironmentVariables {
  Write-Host "Exporting environment variables..." -ForegroundColor Cyan
  
  # Variables to export - only the ones specified by user
  $variablesToExport = @(
    "NUGET_PAT",
    "npm_config_cache",
    "NUGET_PACKAGES",
    "LOCAL_NUGET_PACKAGE_OUTPUT_PATH"
  )
  
  $allEnvVars = @()
  
  # Get system environment variables
  $systemEnvVars = [System.Environment]::GetEnvironmentVariables([System.EnvironmentVariableTarget]::Machine)
  
  foreach ($varName in $variablesToExport) {
    if ($systemEnvVars.Contains($varName)) {
      $allEnvVars += @{
        Name = $varName
        Value = $systemEnvVars[$varName]
        Type = "Machine"
      }
      Write-Host "  Exporting system variable: $varName" -ForegroundColor Green
    }
  }
  
  # Get user environment variables
  $userEnvVars = [System.Environment]::GetEnvironmentVariables([System.EnvironmentVariableTarget]::User)
  
  foreach ($varName in $variablesToExport) {
    if ($userEnvVars.Contains($varName)) {
      $allEnvVars += @{
        Name = $varName
        Value = $userEnvVars[$varName]
        Type = "User"
      }
      Write-Host "  Exporting user variable: $varName" -ForegroundColor Green
    }
  }
  
  # Export to JSON
  $allEnvVars | ConvertTo-Json | Out-File -FilePath .\environment-variables.json
  
  # Create installation script for environment variables
  $installScript = @"
# Environment Variables Installation Script
Write-Host "Setting up environment variables..." -ForegroundColor Cyan

# Read environment variables data
$envVars = Get-Content .\environment-variables.json | ConvertFrom-Json

foreach ($var in $envVars) {
  # Set the environment variable
  try {
      $target = [System.EnvironmentVariableTarget]::User
      if ($var.Type -eq "Machine") {
          # System variables require admin privileges
          $target = [System.EnvironmentVariableTarget]::Machine
      }
      
      Write-Host "Setting $($var.Type) environment variable: $($var.Name)"
      [System.Environment]::SetEnvironmentVariable($var.Name, $var.Value, $target)
  }
  catch {
      Write-Warning "Failed to set environment variable $($var.Name): $_"
  }
}

Write-Host "Environment variables setup complete."
"@
  
  $installScript | Out-File -FilePath .\Install-EnvVariables.ps1
  Write-Host "Environment variables export complete. Installation script created at .\Install-EnvVariables.ps1"
}

# Execute the function
Export-EnvironmentVariables