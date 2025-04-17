# Function to export IIS configuration
function Export-IISConfiguration {
  [CmdletBinding()]
  param(
    [string]$OutputPath = "."
  )
  
  # Determine PowerShell version
  $isPSCore = $PSVersionTable.PSEdition -eq 'Core'
  Write-Host "Using PowerShell $($PSVersionTable.PSVersion) ($($PSVersionTable.PSEdition))" -ForegroundColor Cyan

  # Create output directory if it doesn't exist
  if (-not (Test-Path $OutputPath)) {
    New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
    Write-Host "Created output directory: $OutputPath" -ForegroundColor Green
  }

  # Check if WebAdministration module is available
  $moduleAvailable = $false
  if ($isPSCore) {
    # For PowerShell Core/7
    try {
      $moduleAvailable = Get-Module -Name WebAdministration -SkipEditionCheck -ListAvailable -ErrorAction SilentlyContinue
    } catch {
      # Some versions of PS7 might not support -SkipEditionCheck parameter
      $moduleAvailable = $false
    }
  } else {
    # For Windows PowerShell 5.1
    $moduleAvailable = Get-Module -ListAvailable -Name WebAdministration -ErrorAction SilentlyContinue
  }

  if (!$moduleAvailable) {
    Write-Warning "WebAdministration module not found. IIS export skipped."
    if ($isPSCore) {
      Write-Host "When using PowerShell 7/Core, consider running this script with Windows PowerShell 5.1 instead" -ForegroundColor Yellow
      Write-Host "Or run: Import-Module WebAdministration -SkipEditionCheck" -ForegroundColor Yellow
    } else {
      Write-Host "To install the module, ensure IIS is installed and run one of these commands:"
      Write-Host "- For Windows Desktop: Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementScriptingTools"
    }
    return
  }

  # Try to import the module with error handling
  try {
    # Import required module
    if ($isPSCore) {
      Import-Module WebAdministration -SkipEditionCheck -ErrorAction Stop
      Write-Host "WebAdministration module imported in compatibility mode." -ForegroundColor Green
    } else {
      Import-Module WebAdministration -ErrorAction Stop
      Write-Host "WebAdministration module imported successfully." -ForegroundColor Green
    }
  }
  catch {
    Write-Warning "Failed to import WebAdministration module: $_"
    Write-Host "You might need to restart your computer after installing the required features." -ForegroundColor Yellow
    return
  }

  # Verify IIS is installed and running
  try {
    $iisService = Get-Service -Name W3SVC -ErrorAction SilentlyContinue
    if (-not $iisService) {
      Write-Warning "IIS Web Service (W3SVC) not found. IIS might not be installed."
      return
    }
    
    # Check if IIS path is accessible
    if (-not (Test-Path "IIS:\")) {
      Write-Warning "IIS drive not accessible. IIS might not be configured properly."
      return
    }
    
    Write-Host "IIS detected and accessible." -ForegroundColor Green
  }
  catch {
    Write-Warning "Error checking IIS status: $_"
    return
  }

  # Get all application pools
  Write-Host "Exporting Application Pools..."
  try {
    $appPools = Get-ChildItem IIS:\AppPools | Select-Object Name, State, ManagedRuntimeVersion, ManagedPipelineMode, @{Name='ProcessModel';Expression={$_.processModel.identityType}}
    $appPools | ConvertTo-Json | Out-File -FilePath (Join-Path -Path $OutputPath -ChildPath "iis-apppools.json")
  } catch {
    Write-Warning "Error exporting application pools: $_"
  }

  # Get all websites with error handling
  Write-Host "Exporting Websites..."
  try {
    $websites = Get-ChildItem IIS:\Sites | ForEach-Object {
        $site = $_
        $bindings = $site.Bindings.Collection | ForEach-Object {
            $bindingInfo = $_.bindingInformation
            $protocol = $_.protocol
            @{
                BindingInfo = $bindingInfo
                Protocol = $protocol
            }
        }
        @{
            Name = $site.Name
            ID = $site.ID
            PhysicalPath = $site.PhysicalPath
            Bindings = $bindings
            State = $site.State
            ApplicationPool = $site.ApplicationPool
        }
    }
    $websites | ConvertTo-Json -Depth 5 | Out-File -FilePath (Join-Path -Path $OutputPath -ChildPath "iis-websites.json")
  } catch {
    Write-Warning "Error exporting websites: $_"
  }

  # Get all web applications with error handling
  Write-Host "Exporting Web Applications..."
  try {
    $applications = Get-ChildItem IIS:\Sites | ForEach-Object {
        $siteName = $_.Name
        try {
            Get-WebApplication -Site $siteName | ForEach-Object {
                @{
                    Name = $_.Path.TrimStart('/')
                    SiteName = $siteName
                    PhysicalPath = $_.PhysicalPath
                    ApplicationPool = $_.ApplicationPool
                }
            }
        } catch {
            Write-Warning "Error processing applications for site $siteName`: $_"
            $null # Return null to prevent errors in the pipeline
        }
    }
    # Filter out null entries and convert to JSON
    $applications = $applications | Where-Object {$_ -ne $null}
    $applications | ConvertTo-Json -Depth 5 | Out-File -FilePath (Join-Path -Path $OutputPath -ChildPath "iis-applications.json")
  } catch {
    Write-Warning "Error exporting web applications: $_"
  }

  # Get all virtual directories with error handling
  Write-Host "Exporting Virtual Directories..."
  try {
    $vdirs = Get-ChildItem IIS:\Sites | ForEach-Object {
        $siteName = $_.Name
        try {
            Get-WebVirtualDirectory -Site $siteName | ForEach-Object {
                @{
                    Name = $_.Path.TrimStart('/')
                    SiteName = $siteName
                    PhysicalPath = $_.PhysicalPath
                }
            }
        } catch {
            Write-Warning "Error processing virtual directories for site $siteName`: $_"
            $null # Return null to prevent errors in the pipeline
        }
    }
    # Filter out null entries and convert to JSON
    $vdirs = $vdirs | Where-Object {$_ -ne $null}
    $vdirs | ConvertTo-Json -Depth 5 | Out-File -FilePath (Join-Path -Path $OutputPath -ChildPath "iis-vdirs.json")
  } catch {
    Write-Warning "Error exporting virtual directories: $_"
  }

  Write-Host "IIS configuration export completed to $OutputPath" -ForegroundColor Green
}

# Run the export function only if script is run directly (not dot-sourced)
if ($MyInvocation.InvocationName -ne '.') {
    Export-IISConfiguration
}