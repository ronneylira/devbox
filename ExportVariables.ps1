# Create a dedicated script for environment variables export
$envVarsScript = @"
# Export environment variables (both user and system)

function Export-EnvironmentVariables {
    Write-Host "Exporting environment variables..." -ForegroundColor Cyan
    
    # Get system environment variables
    `$systemEnvVars = [System.Environment]::GetEnvironmentVariables([System.EnvironmentVariableTarget]::Machine)
    `$systemEnvVarsExport = @()
    
    foreach (`$key in `$systemEnvVars.Keys) {
        `$systemEnvVarsExport += @{
            Name = `$key
            Value = `$systemEnvVars[`$key]
            Type = "Machine"
        }
    }
    
    # Get user environment variables
    `$userEnvVars = [System.Environment]::GetEnvironmentVariables([System.EnvironmentVariableTarget]::User)
    `$userEnvVarsExport = @()
    
    foreach (`$key in `$userEnvVars.Keys) {
        `$userEnvVarsExport += @{
            Name = `$key
            Value = `$userEnvVars[`$key]
            Type = "User"
        }
    }
    
    # Combine both exports
    `$allEnvVars = `$systemEnvVarsExport + `$userEnvVarsExport
    
    # Export to JSON
    `$allEnvVars | ConvertTo-Json | Out-File -FilePath .\environment-variables.json
    
    # Create installation script for environment variables
    `$installScript = @"
# Environment Variables Installation Script
Write-Host "Setting up environment variables..." -ForegroundColor Cyan

# Read environment variables data
`$envVars = Get-Content .\environment-variables.json | ConvertFrom-Json

foreach (`$var in `$envVars) {
    # Skip certain system variables that shouldn't be modified
    if (`$var.Name -in @('TEMP', 'TMP', 'windir', 'ProgramFiles', 'ProgramFiles(x86)', 'ProgramData', 'PUBLIC', 'SystemDrive', 'SystemRoot')) {
        Write-Host "Skipping system variable: `$(`$var.Name)" -ForegroundColor Yellow
        continue
    }
    
    # Set the environment variable
    try {
        `$target = [System.EnvironmentVariableTarget]::User
        if (`$var.Type -eq "Machine") {
            # System variables require admin privileges
            `$target = [System.EnvironmentVariableTarget]::Machine
        }
        
        Write-Host "Setting `$(`$var.Type) environment variable: `$(`$var.Name)"
        [System.Environment]::SetEnvironmentVariable(`$var.Name, `$var.Value, `$target)
    }
    catch {
        Write-Warning "Failed to set environment variable `$(`$var.Name): `$_"
    }
}

Write-Host "Environment variables setup complete."
"@
    
    `$installScript | Out-File -FilePath .\Install-EnvVariables.ps1
    Write-Host "Environment variables export complete. Installation script created at .\Install-EnvVariables.ps1"
}

# Execute the function
Export-EnvironmentVariables
"@

$envVarsScript | Out-File -FilePath .\Export-EnvVariables.ps1