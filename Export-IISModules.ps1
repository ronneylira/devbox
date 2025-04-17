# Export IIS modules and handler mappings

function Export-IISModules {
  [CmdletBinding()]
  param(
    [string]$OutputPath = "."
  )
  
  Write-Host "Exporting IIS modules and handler mappings..."
  
  # Create output directory if it doesn't exist
  if (-not (Test-Path $OutputPath)) {
    New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
    Write-Host "Created output directory: $OutputPath" -ForegroundColor Green
  }
  
  Import-Module WebAdministration
  
  # Export global modules
  $globalModules = Get-WebGlobalModule
  $globalModulesExport = $globalModules | Select-Object Name, Image, PreCondition
  $globalModulesExport | ConvertTo-Json | Out-File -FilePath (Join-Path -Path $OutputPath -ChildPath "iis-global-modules.json")
  
  # Export handler mappings
  $handlerMappings = Get-WebHandler -PSPath 'IIS:\'
  $handlerMappingsExport = $handlerMappings | Select-Object Name, Path, Verb, Modules, RequiredAccess, ResourceType, ScriptProcessor
  $handlerMappingsExport | ConvertTo-Json -Depth 5 | Out-File -FilePath (Join-Path -Path $OutputPath -ChildPath "iis-handler-mappings.json")
  
  # Export other IIS settings
  $mimeTypes = Get-WebConfiguration -Filter //staticContent/mimeMap -PSPath 'IIS:\'
  $mimeTypesExport = $mimeTypes | Select-Object fileExtension, mimeType
  $mimeTypesExport | ConvertTo-Json | Out-File -FilePath (Join-Path -Path $OutputPath -ChildPath "iis-mime-types.json")
  
  # Generate DSC configuration for IIS modules
  Generate-IISModulesDsc -OutputPath $OutputPath
  
  Write-Host "IIS modules export completed to $OutputPath" -ForegroundColor Green
}

function Generate-IISModulesDsc {
  [CmdletBinding()]
  param(
    [string]$OutputPath = "."
  )
  
  Write-Host "Generating DSC configuration for IIS modules..."
  
  $dscConfig = @"
# IIS Modules DSC Configuration
Configuration IISModules {
  Import-DscResource -ModuleName xWebAdministration
  
  Node localhost {
      # Ensure IIS is installed first
      WindowsFeature IIS {
          Ensure = "Present"
          Name = "Web-Server"
      }
      
"@

  # Add global modules
  $globalModulesPath = Join-Path -Path $OutputPath -ChildPath "iis-global-modules.json"
  if (Test-Path $globalModulesPath) {
      $modules = Get-Content $globalModulesPath | ConvertFrom-Json
      foreach ($module in $modules) {
          $moduleName = $module.Name -replace '[^a-zA-Z0-9]', ''
          
          $dscConfig += @"
      # IIS Global Module: $($module.Name)
      xIisModule $moduleName {
          Name = "$($module.Name)"
          Path = "$($module.Image)"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }

"@
      }
  }
  
  # Add MIME types
  $mimeTypesPath = Join-Path -Path $OutputPath -ChildPath "iis-mime-types.json"
  if (Test-Path $mimeTypesPath) {
      $mimeTypes = Get-Content $mimeTypesPath | ConvertFrom-Json
      # We'll just include a few custom MIME types that aren't default
      $defaultMimeTypes = @(".htm", ".html", ".jpg", ".jpeg", ".gif", ".png", ".js", ".css", ".txt")
      $customMimeTypes = $mimeTypes | Where-Object { $defaultMimeTypes -notcontains $_.fileExtension }
      
      foreach ($mimeType in $customMimeTypes) {
          $safeName = "MimeType" + ("$($mimeType.fileExtension)" -replace '[^a-zA-Z0-9]', '')
          
          $dscConfig += @"
      # Custom MIME Type: $($mimeType.fileExtension)
      Script $safeName {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = "$($mimeType.fileExtension)"
                  mimeType = "$($mimeType.mimeType)"
              }
          }
          TestScript = {
              $exists = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='$($mimeType.fileExtension)']" -Name "."
              return $exists -ne $null
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='$($mimeType.fileExtension)']" -Name ".") -ne $null
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }

"@
      }
  }
  
  # Close the configuration
  $dscConfig += @"
  }
}
"@

  # Write configuration to file
  $dscConfig | Out-File -FilePath (Join-Path -Path $OutputPath -ChildPath "IISModules-DSC.ps1")
  Write-Host "DSC Configuration for IIS Modules has been generated at $(Join-Path -Path $OutputPath -ChildPath "IISModules-DSC.ps1")"
}

# Execute the function only if script is run directly (not dot-sourced)
if ($MyInvocation.InvocationName -ne '.') {
    Export-IISModules
}