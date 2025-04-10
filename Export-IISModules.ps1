# Export IIS modules and handler mappings

function Export-IISModules {
  Write-Host "Exporting IIS modules and handler mappings..."
  Import-Module WebAdministration
  
  # Export global modules
  $globalModules = Get-WebGlobalModule
  $globalModulesExport = $globalModules | Select-Object Name, Image, PreCondition
  $globalModulesExport | ConvertTo-Json | Out-File -FilePath .\iis-global-modules.json
  
  # Export handler mappings
  $handlerMappings = Get-WebHandler -PSPath 'IIS:\'
  $handlerMappingsExport = $handlerMappings | Select-Object Name, Path, Verb, Modules, RequiredAccess, ResourceType, ScriptProcessor
  $handlerMappingsExport | ConvertTo-Json -Depth 5 | Out-File -FilePath .\iis-handler-mappings.json
  
  # Export other IIS settings
  $mimeTypes = Get-WebConfiguration -Filter //staticContent/mimeMap -PSPath 'IIS:\'
  $mimeTypesExport = $mimeTypes | Select-Object fileExtension, mimeType
  $mimeTypesExport | ConvertTo-Json | Out-File -FilePath .\iis-mime-types.json
  
  # Generate DSC configuration for IIS modules
  Generate-IISModulesDsc
}

function Generate-IISModulesDsc {
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
  if (Test-Path .\iis-global-modules.json) {
      $modules = Get-Content .\iis-global-modules.json | ConvertFrom-Json
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
  if (Test-Path .\iis-mime-types.json) {
      $mimeTypes = Get-Content .\iis-mime-types.json | ConvertFrom-Json
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
  $dscConfig | Out-File -FilePath .\IISModules-DSC.ps1
  Write-Host "DSC Configuration for IIS Modules has been generated at .\IISModules-DSC.ps1"
}

# Execute the function
Export-IISModules