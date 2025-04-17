#Requires -RunAsAdministrator

# Windows 11 Bloatware Removal and Privacy Enhancement Script
# Run this script as Administrator

# Function to display script sections
function Write-Section($text) {
    Write-Host "`n=== $text ===" -ForegroundColor Green
}

# Set execution policy to allow the script to run
Set-ExecutionPolicy Bypass -Scope Process -Force

Write-Section "Removing Bloatware Apps"

# List of bloatware apps to remove
$bloatwareApps = @(
    # Microsoft Bloatware
    "Microsoft.BingNews"
    "Microsoft.BingWeather"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.MixedReality.Portal"
    "Microsoft.People"
    "Microsoft.SkypeApp"
    "Microsoft.WindowsAlarms"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.YourPhone"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    
    # Third-party Bloatware
    "king.com.CandyCrushSaga"
    "king.com.CandyCrushSodaSaga"
    "Disney.37853FC22B2CE"
    "SpotifyAB.SpotifyMusic"
    "4DF9E0F8.Netflix"
    
    # Gaming related (remove if not needed)
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxApp"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.XboxSpeechToTextOverlay"
)

# Remove bloatware apps
foreach ($app in $bloatwareApps) {
    Write-Host "Removing $app..." -ForegroundColor Yellow
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $app | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
}

Write-Section "Disabling Telemetry and Data Collection"

# Disable telemetry
Write-Host "Disabling telemetry and data collection..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0 -Force

# Disable Advertising ID
Write-Host "Disabling Advertising ID..." -ForegroundColor Yellow
If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Force | Out-Null
}
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Type DWord -Value 0 -Force

# Disable Cortana
Write-Host "Disabling Cortana..." -ForegroundColor Yellow
If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0 -Force

Write-Section "Configuring Privacy Settings"

# Disable location tracking
Write-Host "Disabling location tracking..." -ForegroundColor Yellow
If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocation" -Type DWord -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocationScripting" -Type DWord -Value 1 -Force

# Disable app diagnostics
Write-Host "Disabling app diagnostics..." -ForegroundColor Yellow
If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2297E4E2-5DBE-466D-A12B-0F8286F0D9CA}")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2297E4E2-5DBE-466D-A12B-0F8286F0D9CA}" -Force | Out-Null
}
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2297E4E2-5DBE-466D-A12B-0F8286F0D9CA}" -Name "Value" -Type String -Value "Deny" -Force

# Disable feedback frequency
Write-Host "Disabling feedback frequency..." -ForegroundColor Yellow
If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-Null
}
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0 -Force

# Disable tailored experiences
Write-Host "Disabling tailored experiences..." -ForegroundColor Yellow
If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" -Force | Out-Null
}
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" -Name "TailoredExperiencesWithDiagnosticDataEnabled" -Type DWord -Value 0 -Force

# Disable activity history
Write-Host "Disabling activity history..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0 -Force

Write-Section "Disabling Scheduled Tasks"

# Function to safely disable a scheduled task if it exists
function Disable-TaskIfExists {
    param (
        [string]$TaskName
    )
    
    Write-Host "Checking for task: $TaskName" -ForegroundColor Yellow
    
    # Try to get the scheduled task and disable it if it exists
    try {
        $task = Get-ScheduledTask -TaskName $TaskName -ErrorAction Stop
        if ($task) {
            Disable-ScheduledTask -InputObject $task -ErrorAction Stop | Out-Null
            Write-Host "  - Disabled: $TaskName" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "  - Task not found: $TaskName" -ForegroundColor DarkYellow
    }
}

# List of scheduled tasks to disable
$tasksToDisable = @(
    "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser",
    "Microsoft\Windows\Application Experience\ProgramDataUpdater",
    "Microsoft\Windows\Autochk\Proxy",
    "Microsoft\Windows\Customer Experience Improvement Program\Consolidator",
    "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip",
    "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
)

# Disable each task if it exists
Write-Host "Disabling unnecessary scheduled tasks..." -ForegroundColor Yellow
foreach ($task in $tasksToDisable) {
    Disable-TaskIfExists -TaskName $task
}

Write-Section "System Optimization"

# Disable Windows Search indexing service to save resources
Write-Host "Disabling Windows Search indexing service..." -ForegroundColor Yellow
try {
    Stop-Service "WSearch" -Force -ErrorAction SilentlyContinue
    Set-Service "WSearch" -StartupType Disabled -ErrorAction SilentlyContinue
    Write-Host "  - Windows Search service disabled" -ForegroundColor Green
}
catch {
    Write-Host "  - Could not disable Windows Search service" -ForegroundColor DarkYellow
}

# Disable Superfetch service
Write-Host "Disabling Superfetch service..." -ForegroundColor Yellow
try {
    Stop-Service "SysMain" -Force -ErrorAction SilentlyContinue
    Set-Service "SysMain" -StartupType Disabled -ErrorAction SilentlyContinue
    Write-Host "  - Superfetch service disabled" -ForegroundColor Green
}
catch {
    Write-Host "  - Could not disable Superfetch service" -ForegroundColor DarkYellow
}

# Restarting Explorer to apply changes
Write-Host "Restarting Explorer to apply changes..." -ForegroundColor Yellow
try {
    Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue
    Start-Process "explorer"
    Write-Host "  - Explorer restarted" -ForegroundColor Green
}
catch {
    Write-Host "  - Could not restart Explorer" -ForegroundColor DarkYellow
}

Write-Section "Cleanup Complete"
Write-Host "Windows 11 bloatware removal and privacy enhancement complete!" -ForegroundColor Cyan
Write-Host "Some changes may require a system restart to take full effect." -ForegroundColor Yellow
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") 