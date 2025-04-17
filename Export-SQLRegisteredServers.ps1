# Export SQL Server Registered Servers
[CmdletBinding()]
param(
    [Parameter()]
    [string]$OutputPath = "."
)

Write-Host "Exporting SQL Server Registered Servers..." -ForegroundColor Cyan

# Ensure output directory exists
if (-not (Test-Path $OutputPath)) {
    New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
}

# Identify user profile and SQL Server version paths
$userProfilePath = [Environment]::GetFolderPath('UserProfile')
$sqlServerVersions = @(
    "SQL Server Management Studio 19",
    "SQL Server Management Studio 18",
    "SQL Server Management Studio 17",
    "Microsoft SQL Server Management Studio 18",
    "Microsoft SQL Server Management Studio 17",
    "Sql Server Management Studio 19",
    "Sql Server Management Studio 18",
    "Sql Server Management Studio 17"
)

$registeredServersExported = $false
$registeredServersFiles = @()

# Function to copy a registered servers file with proper error handling
function Copy-RegisteredServersFile {
    param (
        [string]$SourcePath,
        [string]$DestinationPath,
        [string]$Version
    )
    
    try {
        if (Test-Path $SourcePath) {
            Copy-Item -Path $SourcePath -Destination $DestinationPath -Force
            Write-Host "SQL Server $Version registered servers exported successfully" -ForegroundColor Green
            return $true
        }
    }
    catch {
        Write-Warning "Error copying registered servers file from $SourcePath`: $_"
    }
    
    return $false
}

# Look for registered servers in standard locations
foreach ($version in $sqlServerVersions) {
    # Standard path format
    $registeredServersPath = Join-Path -Path $userProfilePath -ChildPath "AppData\Roaming\Microsoft\$version\RegisteredServers\RegisteredServers.xml"
    $destinationFile = Join-Path -Path $OutputPath -ChildPath "RegisteredServers-$($version.Replace(' ', '-')).xml"
    
    if (Copy-RegisteredServersFile -SourcePath $registeredServersPath -DestinationPath $destinationFile -Version $version) {
        $registeredServersExported = $true
        $registeredServersFiles += @{
            Version = $version
            Path = $destinationFile
            OriginalPath = $registeredServersPath
        }
    }
}

# Also check SQL Server's default mssql folder locations for SSMS v19
$mssqlPaths = @(
    "AppData\Roaming\Microsoft\mssql\RegisteredServers\RegisteredServers.xml",
    "AppData\Roaming\Microsoft\mssql19.0\RegisteredServers\RegisteredServers.xml",
    "AppData\Roaming\Microsoft\mssql18.0\RegisteredServers\RegisteredServers.xml",
    "AppData\Roaming\Microsoft\mssql17.0\RegisteredServers\RegisteredServers.xml"
)

foreach ($path in $mssqlPaths) {
    $registeredServersPath = Join-Path -Path $userProfilePath -ChildPath $path
    $versionName = if ($path -like "*mssql19.0*") { "MSSQL19" } 
                   elseif ($path -like "*mssql18.0*") { "MSSQL18" }
                   elseif ($path -like "*mssql17.0*") { "MSSQL17" }
                   else { "MSSQL" }
    $destinationFile = Join-Path -Path $OutputPath -ChildPath "RegisteredServers-$versionName.xml"
    
    if (Copy-RegisteredServersFile -SourcePath $registeredServersPath -DestinationPath $destinationFile -Version $versionName) {
        $registeredServersExported = $true
        $registeredServersFiles += @{
            Version = $versionName
            Path = $destinationFile
            OriginalPath = $registeredServersPath
        }
    }
}

# Azure Data Studio settings
$azdsPaths = @(
    "AppData\Roaming\azuredatastudio\User\settings.json",
    ".azuredatastudio\User\settings.json"
)

foreach ($path in $azdsPaths) {
    $azdsSettingsPath = Join-Path -Path $userProfilePath -ChildPath $path
    $destinationFile = Join-Path -Path $OutputPath -ChildPath "AzureDataStudio-Settings.json"
    
    if (Test-Path $azdsSettingsPath) {
        try {
            Copy-Item -Path $azdsSettingsPath -Destination $destinationFile -Force
            Write-Host "Azure Data Studio settings exported successfully" -ForegroundColor Green
            $registeredServersExported = $true
            $registeredServersFiles += @{
                Version = "AzureDataStudio"
                Path = $destinationFile
                OriginalPath = $azdsSettingsPath
            }
        }
        catch {
            Write-Warning "Error exporting Azure Data Studio settings: $_"
        }
    }
}

# Create installation script for import
if ($registeredServersExported) {
    $installScript = @"
# SQL Server Registered Servers Import Script
[CmdletBinding()]
param(
    [Parameter()]
    [string]`$InputPath = "."
)

Write-Host "Importing SQL Server Registered Servers..." -ForegroundColor Cyan

# Identify user profile path
`$userProfilePath = [Environment]::GetFolderPath('UserProfile')

"@

    # Add import commands for each found registered servers file
    foreach ($file in $registeredServersFiles) {
        $fileName = Split-Path -Path $file.Path -Leaf
        $installScript += @"

# Import $($file.Version) registered servers
`$sourcePath = Join-Path -Path `$InputPath -ChildPath "$fileName"
if (Test-Path `$sourcePath) {
    # Determine target path
    `$targetDirectory = Split-Path -Path "$($file.OriginalPath)" -Parent
    
    # Ensure target directory exists
    if (-not (Test-Path `$targetDirectory)) {
        try {
            New-Item -Path `$targetDirectory -ItemType Directory -Force | Out-Null
            Write-Host "Created directory: `$targetDirectory" -ForegroundColor Gray
        }
        catch {
            Write-Warning "Could not create directory `$targetDirectory`: `$_"
            continue
        }
    }
    
    try {
        Copy-Item -Path `$sourcePath -Destination "$($file.OriginalPath)" -Force
        Write-Host "$($file.Version) registered servers imported successfully" -ForegroundColor Green
    }
    catch {
        Write-Warning "Error importing $($file.Version) registered servers: `$_"
    }
}
else {
    Write-Warning "$($file.Version) registered servers file not found: `$sourcePath"
}

"@
    }

    # Add final completion message
    $installScript += @"
Write-Host "SQL Server registered servers import complete!" -ForegroundColor Green
"@

    # Save the install script
    $installScriptPath = Join-Path -Path $OutputPath -ChildPath "Install-SQLRegisteredServers.ps1"
    $installScript | Out-File -FilePath $installScriptPath -Encoding UTF8
    
    Write-Host "SQL Server registered servers export completed" -ForegroundColor Green
    Write-Host "Found $($registeredServersFiles.Count) registered servers configurations" -ForegroundColor Green
    Write-Host "Installation script created at: $installScriptPath" -ForegroundColor Green
}
else {
    Write-Warning "No SQL Server registered servers found to export"
    
    # Create empty install script that explains the situation
    $emptyInstallScript = @"
# SQL Server Registered Servers Import Script
Write-Host "No SQL Server registered servers were exported from the source machine." -ForegroundColor Yellow
Write-Host "This could be because:"
Write-Host "1. SQL Server Management Studio is not installed"
Write-Host "2. No registered servers are configured"
Write-Host "3. Registered servers are stored in a non-standard location"
"@
    
    $installScriptPath = Join-Path -Path $OutputPath -ChildPath "Install-SQLRegisteredServers.ps1"
    $emptyInstallScript | Out-File -FilePath $installScriptPath -Encoding UTF8
    
    Write-Host "Empty SQL Server registered servers installation script created at: $installScriptPath" -ForegroundColor Yellow
} 