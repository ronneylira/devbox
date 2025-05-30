# IIS Modules DSC Configuration
Configuration IISModules {
  Import-DscResource -ModuleName xWebAdministration
  
  Node localhost {
      # Ensure IIS is installed first
      WindowsFeature IIS {
          Ensure = "Present"
          Name = "Web-Server"
      }
            # IIS Global Module: HttpLoggingModule
      xIisModule HttpLoggingModule {
          Name = "HttpLoggingModule"
          Path = "%windir%\System32\inetsrv\loghttp.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: UriCacheModule
      xIisModule UriCacheModule {
          Name = "UriCacheModule"
          Path = "%windir%\System32\inetsrv\cachuri.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: FileCacheModule
      xIisModule FileCacheModule {
          Name = "FileCacheModule"
          Path = "%windir%\System32\inetsrv\cachfile.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: TokenCacheModule
      xIisModule TokenCacheModule {
          Name = "TokenCacheModule"
          Path = "%windir%\System32\inetsrv\cachtokn.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: HttpCacheModule
      xIisModule HttpCacheModule {
          Name = "HttpCacheModule"
          Path = "%windir%\System32\inetsrv\cachhttp.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: StaticCompressionModule
      xIisModule StaticCompressionModule {
          Name = "StaticCompressionModule"
          Path = "%windir%\System32\inetsrv\compstat.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: DefaultDocumentModule
      xIisModule DefaultDocumentModule {
          Name = "DefaultDocumentModule"
          Path = "%windir%\System32\inetsrv\defdoc.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: ProtocolSupportModule
      xIisModule ProtocolSupportModule {
          Name = "ProtocolSupportModule"
          Path = "%windir%\System32\inetsrv\protsup.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: ServerSideIncludeModule
      xIisModule ServerSideIncludeModule {
          Name = "ServerSideIncludeModule"
          Path = "%windir%\System32\inetsrv\iis_ssi.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: AnonymousAuthenticationModule
      xIisModule AnonymousAuthenticationModule {
          Name = "AnonymousAuthenticationModule"
          Path = "%windir%\System32\inetsrv\authanon.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: RequestFilteringModule
      xIisModule RequestFilteringModule {
          Name = "RequestFilteringModule"
          Path = "%windir%\System32\inetsrv\modrqflt.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: IsapiModule
      xIisModule IsapiModule {
          Name = "IsapiModule"
          Path = "%windir%\System32\inetsrv\isapi.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: IsapiFilterModule
      xIisModule IsapiFilterModule {
          Name = "IsapiFilterModule"
          Path = "%windir%\System32\inetsrv\filter.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: CgiModule
      xIisModule CgiModule {
          Name = "CgiModule"
          Path = "%windir%\System32\inetsrv\cgi.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: FastCgiModule
      xIisModule FastCgiModule {
          Name = "FastCgiModule"
          Path = "%windir%\System32\inetsrv\iisfcgi.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: ConfigurationValidationModule
      xIisModule ConfigurationValidationModule {
          Name = "ConfigurationValidationModule"
          Path = "%windir%\System32\inetsrv\validcfg.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: WebSocketModule
      xIisModule WebSocketModule {
          Name = "WebSocketModule"
          Path = "%windir%\System32\inetsrv\iiswsock.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: ApplicationInitializationModule
      xIisModule ApplicationInitializationModule {
          Name = "ApplicationInitializationModule"
          Path = "%windir%\System32\inetsrv\warmup.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: StaticFileModule
      xIisModule StaticFileModule {
          Name = "StaticFileModule"
          Path = "%windir%\System32\inetsrv\static.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: ManagedEngineV4.0_32bit
      xIisModule ManagedEngineV4032bit {
          Name = "ManagedEngineV4.0_32bit"
          Path = "%windir%\Microsoft.NET\Framework\v4.0.30319\webengine4.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # IIS Global Module: ManagedEngineV4.0_64bit
      xIisModule ManagedEngineV4064bit {
          Name = "ManagedEngineV4.0_64bit"
          Path = "%windir%\Microsoft.NET\Framework64\v4.0.30319\webengine4.dll"
          RequestPath = "*"
          Ensure = "Present"
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .323
      Script MimeType323 {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".323"
                  mimeType = "text/h323"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.323']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.323']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .3g2
      Script MimeType3g2 {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".3g2"
                  mimeType = "video/3gpp2"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.3g2']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.3g2']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .3gp2
      Script MimeType3gp2 {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".3gp2"
                  mimeType = "video/3gpp2"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.3gp2']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.3gp2']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .3gp
      Script MimeType3gp {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".3gp"
                  mimeType = "video/3gpp"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.3gp']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.3gp']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .3gpp
      Script MimeType3gpp {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".3gpp"
                  mimeType = "video/3gpp"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.3gpp']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.3gpp']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .aaf
      Script MimeTypeaaf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".aaf"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.aaf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.aaf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .aac
      Script MimeTypeaac {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".aac"
                  mimeType = "audio/aac"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.aac']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.aac']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .aca
      Script MimeTypeaca {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".aca"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.aca']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.aca']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .accdb
      Script MimeTypeaccdb {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".accdb"
                  mimeType = "application/msaccess"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.accdb']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.accdb']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .accde
      Script MimeTypeaccde {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".accde"
                  mimeType = "application/msaccess"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.accde']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.accde']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .accdt
      Script MimeTypeaccdt {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".accdt"
                  mimeType = "application/msaccess"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.accdt']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.accdt']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .acx
      Script MimeTypeacx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".acx"
                  mimeType = "application/internet-property-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.acx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.acx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .adt
      Script MimeTypeadt {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".adt"
                  mimeType = "audio/vnd.dlna.adts"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.adt']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.adt']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .adts
      Script MimeTypeadts {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".adts"
                  mimeType = "audio/vnd.dlna.adts"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.adts']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.adts']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .afm
      Script MimeTypeafm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".afm"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.afm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.afm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ai
      Script MimeTypeai {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ai"
                  mimeType = "application/postscript"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ai']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ai']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .aif
      Script MimeTypeaif {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".aif"
                  mimeType = "audio/x-aiff"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.aif']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.aif']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .aifc
      Script MimeTypeaifc {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".aifc"
                  mimeType = "audio/aiff"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.aifc']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.aifc']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .aiff
      Script MimeTypeaiff {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".aiff"
                  mimeType = "audio/aiff"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.aiff']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.aiff']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .appcache
      Script MimeTypeappcache {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".appcache"
                  mimeType = "text/cache-manifest"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.appcache']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.appcache']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .application
      Script MimeTypeapplication {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".application"
                  mimeType = "application/x-ms-application"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.application']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.application']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .art
      Script MimeTypeart {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".art"
                  mimeType = "image/x-jg"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.art']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.art']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .asd
      Script MimeTypeasd {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".asd"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.asd']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.asd']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .asf
      Script MimeTypeasf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".asf"
                  mimeType = "video/x-ms-asf"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.asf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.asf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .asi
      Script MimeTypeasi {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".asi"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.asi']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.asi']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .asm
      Script MimeTypeasm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".asm"
                  mimeType = "text/plain"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.asm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.asm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .asr
      Script MimeTypeasr {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".asr"
                  mimeType = "video/x-ms-asf"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.asr']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.asr']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .asx
      Script MimeTypeasx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".asx"
                  mimeType = "video/x-ms-asf"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.asx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.asx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .atom
      Script MimeTypeatom {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".atom"
                  mimeType = "application/atom+xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.atom']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.atom']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .au
      Script MimeTypeau {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".au"
                  mimeType = "audio/basic"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.au']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.au']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .avi
      Script MimeTypeavi {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".avi"
                  mimeType = "video/avi"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.avi']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.avi']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .axs
      Script MimeTypeaxs {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".axs"
                  mimeType = "application/olescript"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.axs']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.axs']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .bas
      Script MimeTypebas {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".bas"
                  mimeType = "text/plain"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.bas']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.bas']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .bcpio
      Script MimeTypebcpio {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".bcpio"
                  mimeType = "application/x-bcpio"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.bcpio']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.bcpio']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .bin
      Script MimeTypebin {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".bin"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.bin']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.bin']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .bmp
      Script MimeTypebmp {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".bmp"
                  mimeType = "image/bmp"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.bmp']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.bmp']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .c
      Script MimeTypec {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".c"
                  mimeType = "text/plain"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.c']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.c']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .cab
      Script MimeTypecab {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".cab"
                  mimeType = "application/vnd.ms-cab-compressed"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.cab']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.cab']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .calx
      Script MimeTypecalx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".calx"
                  mimeType = "application/vnd.ms-office.calx"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.calx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.calx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .cat
      Script MimeTypecat {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".cat"
                  mimeType = "application/vnd.ms-pki.seccat"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.cat']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.cat']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .cdf
      Script MimeTypecdf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".cdf"
                  mimeType = "application/x-cdf"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.cdf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.cdf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .chm
      Script MimeTypechm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".chm"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.chm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.chm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .class
      Script MimeTypeclass {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".class"
                  mimeType = "application/x-java-applet"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.class']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.class']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .clp
      Script MimeTypeclp {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".clp"
                  mimeType = "application/x-msclip"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.clp']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.clp']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .cmx
      Script MimeTypecmx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".cmx"
                  mimeType = "image/x-cmx"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.cmx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.cmx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .cnf
      Script MimeTypecnf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".cnf"
                  mimeType = "text/plain"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.cnf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.cnf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .cod
      Script MimeTypecod {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".cod"
                  mimeType = "image/cis-cod"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.cod']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.cod']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .cpio
      Script MimeTypecpio {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".cpio"
                  mimeType = "application/x-cpio"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.cpio']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.cpio']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .cpp
      Script MimeTypecpp {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".cpp"
                  mimeType = "text/plain"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.cpp']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.cpp']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .crd
      Script MimeTypecrd {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".crd"
                  mimeType = "application/x-mscardfile"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.crd']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.crd']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .crl
      Script MimeTypecrl {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".crl"
                  mimeType = "application/pkix-crl"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.crl']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.crl']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .crt
      Script MimeTypecrt {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".crt"
                  mimeType = "application/x-x509-ca-cert"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.crt']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.crt']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .csh
      Script MimeTypecsh {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".csh"
                  mimeType = "application/x-csh"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.csh']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.csh']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .csv
      Script MimeTypecsv {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".csv"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.csv']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.csv']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .cur
      Script MimeTypecur {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".cur"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.cur']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.cur']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .dcr
      Script MimeTypedcr {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".dcr"
                  mimeType = "application/x-director"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dcr']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dcr']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .deploy
      Script MimeTypedeploy {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".deploy"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.deploy']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.deploy']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .der
      Script MimeTypeder {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".der"
                  mimeType = "application/x-x509-ca-cert"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.der']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.der']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .dib
      Script MimeTypedib {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".dib"
                  mimeType = "image/bmp"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dib']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dib']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .dir
      Script MimeTypedir {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".dir"
                  mimeType = "application/x-director"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dir']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dir']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .disco
      Script MimeTypedisco {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".disco"
                  mimeType = "text/xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.disco']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.disco']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .dll
      Script MimeTypedll {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".dll"
                  mimeType = "application/x-msdownload"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dll']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dll']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .dll.config
      Script MimeTypedllconfig {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".dll.config"
                  mimeType = "text/xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dll.config']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dll.config']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .dlm
      Script MimeTypedlm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".dlm"
                  mimeType = "text/dlm"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dlm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dlm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .doc
      Script MimeTypedoc {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".doc"
                  mimeType = "application/msword"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.doc']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.doc']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .docm
      Script MimeTypedocm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".docm"
                  mimeType = "application/vnd.ms-word.document.macroEnabled.12"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.docm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.docm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .docx
      Script MimeTypedocx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".docx"
                  mimeType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.docx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.docx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .dot
      Script MimeTypedot {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".dot"
                  mimeType = "application/msword"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dot']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dot']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .dotm
      Script MimeTypedotm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".dotm"
                  mimeType = "application/vnd.ms-word.template.macroEnabled.12"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dotm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dotm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .dotx
      Script MimeTypedotx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".dotx"
                  mimeType = "application/vnd.openxmlformats-officedocument.wordprocessingml.template"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dotx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dotx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .dsp
      Script MimeTypedsp {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".dsp"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dsp']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dsp']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .dtd
      Script MimeTypedtd {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".dtd"
                  mimeType = "text/xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dtd']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dtd']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .dvi
      Script MimeTypedvi {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".dvi"
                  mimeType = "application/x-dvi"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dvi']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dvi']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .dvr-ms
      Script MimeTypedvrms {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".dvr-ms"
                  mimeType = "video/x-ms-dvr"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dvr-ms']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dvr-ms']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .dwf
      Script MimeTypedwf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".dwf"
                  mimeType = "drawing/x-dwf"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dwf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dwf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .dwp
      Script MimeTypedwp {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".dwp"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dwp']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dwp']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .dxr
      Script MimeTypedxr {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".dxr"
                  mimeType = "application/x-director"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dxr']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.dxr']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .eml
      Script MimeTypeeml {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".eml"
                  mimeType = "message/rfc822"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.eml']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.eml']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .emz
      Script MimeTypeemz {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".emz"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.emz']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.emz']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .eot
      Script MimeTypeeot {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".eot"
                  mimeType = "application/vnd.ms-fontobject"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.eot']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.eot']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .eps
      Script MimeTypeeps {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".eps"
                  mimeType = "application/postscript"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.eps']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.eps']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .esd
      Script MimeTypeesd {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".esd"
                  mimeType = "application/vnd.ms-cab-compressed"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.esd']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.esd']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .etx
      Script MimeTypeetx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".etx"
                  mimeType = "text/x-setext"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.etx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.etx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .evy
      Script MimeTypeevy {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".evy"
                  mimeType = "application/envoy"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.evy']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.evy']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .exe
      Script MimeTypeexe {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".exe"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.exe']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.exe']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .exe.config
      Script MimeTypeexeconfig {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".exe.config"
                  mimeType = "text/xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.exe.config']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.exe.config']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .fdf
      Script MimeTypefdf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".fdf"
                  mimeType = "application/vnd.fdf"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.fdf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.fdf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .fif
      Script MimeTypefif {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".fif"
                  mimeType = "application/fractals"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.fif']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.fif']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .fla
      Script MimeTypefla {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".fla"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.fla']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.fla']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .flr
      Script MimeTypeflr {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".flr"
                  mimeType = "x-world/x-vrml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.flr']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.flr']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .flv
      Script MimeTypeflv {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".flv"
                  mimeType = "video/x-flv"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.flv']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.flv']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .glb
      Script MimeTypeglb {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".glb"
                  mimeType = "model/gltf-binary"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.glb']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.glb']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .gtar
      Script MimeTypegtar {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".gtar"
                  mimeType = "application/x-gtar"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.gtar']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.gtar']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .gz
      Script MimeTypegz {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".gz"
                  mimeType = "application/x-gzip"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.gz']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.gz']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .h
      Script MimeTypeh {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".h"
                  mimeType = "text/plain"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.h']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.h']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .hdf
      Script MimeTypehdf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".hdf"
                  mimeType = "application/x-hdf"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.hdf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.hdf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .hdml
      Script MimeTypehdml {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".hdml"
                  mimeType = "text/x-hdml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.hdml']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.hdml']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .hhc
      Script MimeTypehhc {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".hhc"
                  mimeType = "application/x-oleobject"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.hhc']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.hhc']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .hhk
      Script MimeTypehhk {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".hhk"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.hhk']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.hhk']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .hhp
      Script MimeTypehhp {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".hhp"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.hhp']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.hhp']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .hlp
      Script MimeTypehlp {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".hlp"
                  mimeType = "application/winhlp"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.hlp']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.hlp']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .hqx
      Script MimeTypehqx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".hqx"
                  mimeType = "application/mac-binhex40"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.hqx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.hqx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .hta
      Script MimeTypehta {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".hta"
                  mimeType = "application/hta"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.hta']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.hta']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .htc
      Script MimeTypehtc {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".htc"
                  mimeType = "text/x-component"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.htc']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.htc']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .htt
      Script MimeTypehtt {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".htt"
                  mimeType = "text/webviewhtml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.htt']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.htt']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .hxt
      Script MimeTypehxt {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".hxt"
                  mimeType = "text/html"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.hxt']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.hxt']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ico
      Script MimeTypeico {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ico"
                  mimeType = "image/x-icon"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ico']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ico']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ics
      Script MimeTypeics {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ics"
                  mimeType = "text/calendar"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ics']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ics']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ief
      Script MimeTypeief {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ief"
                  mimeType = "image/ief"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ief']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ief']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .iii
      Script MimeTypeiii {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".iii"
                  mimeType = "application/x-iphone"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.iii']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.iii']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .inf
      Script MimeTypeinf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".inf"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.inf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.inf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ins
      Script MimeTypeins {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ins"
                  mimeType = "application/x-internet-signup"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ins']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ins']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .isp
      Script MimeTypeisp {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".isp"
                  mimeType = "application/x-internet-signup"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.isp']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.isp']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .IVF
      Script MimeTypeIVF {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".IVF"
                  mimeType = "video/x-ivf"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.IVF']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.IVF']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .jar
      Script MimeTypejar {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".jar"
                  mimeType = "application/java-archive"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.jar']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.jar']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .java
      Script MimeTypejava {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".java"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.java']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.java']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .jck
      Script MimeTypejck {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".jck"
                  mimeType = "application/liquidmotion"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.jck']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.jck']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .jcz
      Script MimeTypejcz {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".jcz"
                  mimeType = "application/liquidmotion"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.jcz']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.jcz']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .jfif
      Script MimeTypejfif {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".jfif"
                  mimeType = "image/pjpeg"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.jfif']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.jfif']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .jpb
      Script MimeTypejpb {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".jpb"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.jpb']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.jpb']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .jpe
      Script MimeTypejpe {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".jpe"
                  mimeType = "image/jpeg"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.jpe']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.jpe']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .json
      Script MimeTypejson {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".json"
                  mimeType = "application/json"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.json']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.json']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .jsonld
      Script MimeTypejsonld {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".jsonld"
                  mimeType = "application/ld+json"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.jsonld']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.jsonld']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .jsx
      Script MimeTypejsx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".jsx"
                  mimeType = "text/jscript"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.jsx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.jsx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .latex
      Script MimeTypelatex {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".latex"
                  mimeType = "application/x-latex"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.latex']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.latex']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .less
      Script MimeTypeless {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".less"
                  mimeType = "text/css"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.less']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.less']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .lit
      Script MimeTypelit {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".lit"
                  mimeType = "application/x-ms-reader"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.lit']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.lit']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .lpk
      Script MimeTypelpk {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".lpk"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.lpk']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.lpk']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .lsf
      Script MimeTypelsf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".lsf"
                  mimeType = "video/x-la-asf"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.lsf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.lsf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .lsx
      Script MimeTypelsx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".lsx"
                  mimeType = "video/x-la-asf"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.lsx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.lsx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .lzh
      Script MimeTypelzh {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".lzh"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.lzh']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.lzh']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .m13
      Script MimeTypem13 {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".m13"
                  mimeType = "application/x-msmediaview"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.m13']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.m13']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .m14
      Script MimeTypem14 {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".m14"
                  mimeType = "application/x-msmediaview"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.m14']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.m14']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .m1v
      Script MimeTypem1v {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".m1v"
                  mimeType = "video/mpeg"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.m1v']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.m1v']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .m2ts
      Script MimeTypem2ts {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".m2ts"
                  mimeType = "video/vnd.dlna.mpeg-tts"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.m2ts']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.m2ts']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .m3u
      Script MimeTypem3u {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".m3u"
                  mimeType = "audio/x-mpegurl"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.m3u']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.m3u']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .m4a
      Script MimeTypem4a {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".m4a"
                  mimeType = "audio/mp4"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.m4a']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.m4a']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .m4v
      Script MimeTypem4v {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".m4v"
                  mimeType = "video/mp4"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.m4v']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.m4v']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .man
      Script MimeTypeman {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".man"
                  mimeType = "application/x-troff-man"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.man']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.man']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .manifest
      Script MimeTypemanifest {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".manifest"
                  mimeType = "application/x-ms-manifest"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.manifest']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.manifest']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .map
      Script MimeTypemap {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".map"
                  mimeType = "text/plain"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.map']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.map']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mdb
      Script MimeTypemdb {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mdb"
                  mimeType = "application/x-msaccess"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mdb']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mdb']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mdp
      Script MimeTypemdp {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mdp"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mdp']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mdp']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .me
      Script MimeTypeme {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".me"
                  mimeType = "application/x-troff-me"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.me']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.me']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mht
      Script MimeTypemht {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mht"
                  mimeType = "message/rfc822"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mht']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mht']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mhtml
      Script MimeTypemhtml {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mhtml"
                  mimeType = "message/rfc822"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mhtml']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mhtml']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mid
      Script MimeTypemid {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mid"
                  mimeType = "audio/mid"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mid']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mid']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .midi
      Script MimeTypemidi {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".midi"
                  mimeType = "audio/mid"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.midi']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.midi']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mix
      Script MimeTypemix {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mix"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mix']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mix']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mmf
      Script MimeTypemmf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mmf"
                  mimeType = "application/x-smaf"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mmf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mmf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mno
      Script MimeTypemno {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mno"
                  mimeType = "text/xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mno']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mno']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mny
      Script MimeTypemny {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mny"
                  mimeType = "application/x-msmoney"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mny']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mny']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mov
      Script MimeTypemov {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mov"
                  mimeType = "video/quicktime"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mov']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mov']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .movie
      Script MimeTypemovie {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".movie"
                  mimeType = "video/x-sgi-movie"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.movie']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.movie']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mp2
      Script MimeTypemp2 {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mp2"
                  mimeType = "video/mpeg"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mp2']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mp2']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mp3
      Script MimeTypemp3 {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mp3"
                  mimeType = "audio/mpeg"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mp3']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mp3']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mp4
      Script MimeTypemp4 {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mp4"
                  mimeType = "video/mp4"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mp4']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mp4']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mp4v
      Script MimeTypemp4v {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mp4v"
                  mimeType = "video/mp4"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mp4v']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mp4v']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mpa
      Script MimeTypempa {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mpa"
                  mimeType = "video/mpeg"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mpa']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mpa']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mpe
      Script MimeTypempe {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mpe"
                  mimeType = "video/mpeg"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mpe']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mpe']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mpeg
      Script MimeTypempeg {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mpeg"
                  mimeType = "video/mpeg"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mpeg']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mpeg']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mpg
      Script MimeTypempg {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mpg"
                  mimeType = "video/mpeg"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mpg']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mpg']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mpp
      Script MimeTypempp {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mpp"
                  mimeType = "application/vnd.ms-project"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mpp']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mpp']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mpv2
      Script MimeTypempv2 {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mpv2"
                  mimeType = "video/mpeg"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mpv2']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mpv2']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ms
      Script MimeTypems {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ms"
                  mimeType = "application/x-troff-ms"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ms']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ms']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .msi
      Script MimeTypemsi {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".msi"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.msi']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.msi']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mso
      Script MimeTypemso {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mso"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mso']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mso']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mvb
      Script MimeTypemvb {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mvb"
                  mimeType = "application/x-msmediaview"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mvb']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mvb']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .mvc
      Script MimeTypemvc {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".mvc"
                  mimeType = "application/x-miva-compiled"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mvc']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.mvc']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .nc
      Script MimeTypenc {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".nc"
                  mimeType = "application/x-netcdf"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.nc']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.nc']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .nsc
      Script MimeTypensc {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".nsc"
                  mimeType = "video/x-ms-asf"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.nsc']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.nsc']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .nws
      Script MimeTypenws {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".nws"
                  mimeType = "message/rfc822"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.nws']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.nws']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ocx
      Script MimeTypeocx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ocx"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ocx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ocx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .oda
      Script MimeTypeoda {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".oda"
                  mimeType = "application/oda"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.oda']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.oda']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .odc
      Script MimeTypeodc {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".odc"
                  mimeType = "text/x-ms-odc"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.odc']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.odc']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ods
      Script MimeTypeods {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ods"
                  mimeType = "application/oleobject"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ods']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ods']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .oga
      Script MimeTypeoga {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".oga"
                  mimeType = "audio/ogg"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.oga']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.oga']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ogg
      Script MimeTypeogg {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ogg"
                  mimeType = "video/ogg"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ogg']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ogg']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ogv
      Script MimeTypeogv {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ogv"
                  mimeType = "video/ogg"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ogv']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ogv']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .one
      Script MimeTypeone {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".one"
                  mimeType = "application/onenote"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.one']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.one']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .onea
      Script MimeTypeonea {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".onea"
                  mimeType = "application/onenote"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.onea']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.onea']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .onetoc
      Script MimeTypeonetoc {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".onetoc"
                  mimeType = "application/onenote"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.onetoc']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.onetoc']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .onetoc2
      Script MimeTypeonetoc2 {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".onetoc2"
                  mimeType = "application/onenote"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.onetoc2']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.onetoc2']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .onetmp
      Script MimeTypeonetmp {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".onetmp"
                  mimeType = "application/onenote"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.onetmp']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.onetmp']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .onepkg
      Script MimeTypeonepkg {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".onepkg"
                  mimeType = "application/onenote"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.onepkg']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.onepkg']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .osdx
      Script MimeTypeosdx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".osdx"
                  mimeType = "application/opensearchdescription+xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.osdx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.osdx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .otf
      Script MimeTypeotf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".otf"
                  mimeType = "font/otf"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.otf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.otf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .p10
      Script MimeTypep10 {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".p10"
                  mimeType = "application/pkcs10"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.p10']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.p10']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .p12
      Script MimeTypep12 {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".p12"
                  mimeType = "application/x-pkcs12"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.p12']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.p12']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .p7b
      Script MimeTypep7b {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".p7b"
                  mimeType = "application/x-pkcs7-certificates"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.p7b']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.p7b']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .p7c
      Script MimeTypep7c {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".p7c"
                  mimeType = "application/pkcs7-mime"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.p7c']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.p7c']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .p7m
      Script MimeTypep7m {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".p7m"
                  mimeType = "application/pkcs7-mime"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.p7m']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.p7m']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .p7r
      Script MimeTypep7r {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".p7r"
                  mimeType = "application/x-pkcs7-certreqresp"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.p7r']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.p7r']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .p7s
      Script MimeTypep7s {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".p7s"
                  mimeType = "application/pkcs7-signature"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.p7s']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.p7s']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pbm
      Script MimeTypepbm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pbm"
                  mimeType = "image/x-portable-bitmap"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pbm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pbm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pcx
      Script MimeTypepcx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pcx"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pcx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pcx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pcz
      Script MimeTypepcz {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pcz"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pcz']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pcz']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pdf
      Script MimeTypepdf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pdf"
                  mimeType = "application/pdf"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pdf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pdf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pfb
      Script MimeTypepfb {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pfb"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pfb']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pfb']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pfm
      Script MimeTypepfm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pfm"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pfm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pfm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pfx
      Script MimeTypepfx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pfx"
                  mimeType = "application/x-pkcs12"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pfx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pfx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pgm
      Script MimeTypepgm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pgm"
                  mimeType = "image/x-portable-graymap"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pgm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pgm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pko
      Script MimeTypepko {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pko"
                  mimeType = "application/vnd.ms-pki.pko"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pko']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pko']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pma
      Script MimeTypepma {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pma"
                  mimeType = "application/x-perfmon"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pma']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pma']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pmc
      Script MimeTypepmc {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pmc"
                  mimeType = "application/x-perfmon"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pmc']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pmc']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pml
      Script MimeTypepml {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pml"
                  mimeType = "application/x-perfmon"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pml']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pml']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pmr
      Script MimeTypepmr {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pmr"
                  mimeType = "application/x-perfmon"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pmr']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pmr']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pmw
      Script MimeTypepmw {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pmw"
                  mimeType = "application/x-perfmon"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pmw']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pmw']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pnm
      Script MimeTypepnm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pnm"
                  mimeType = "image/x-portable-anymap"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pnm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pnm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pnz
      Script MimeTypepnz {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pnz"
                  mimeType = "image/png"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pnz']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pnz']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pot
      Script MimeTypepot {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pot"
                  mimeType = "application/vnd.ms-powerpoint"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pot']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pot']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .potm
      Script MimeTypepotm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".potm"
                  mimeType = "application/vnd.ms-powerpoint.template.macroEnabled.12"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.potm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.potm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .potx
      Script MimeTypepotx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".potx"
                  mimeType = "application/vnd.openxmlformats-officedocument.presentationml.template"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.potx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.potx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ppam
      Script MimeTypeppam {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ppam"
                  mimeType = "application/vnd.ms-powerpoint.addin.macroEnabled.12"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ppam']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ppam']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ppm
      Script MimeTypeppm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ppm"
                  mimeType = "image/x-portable-pixmap"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ppm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ppm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pps
      Script MimeTypepps {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pps"
                  mimeType = "application/vnd.ms-powerpoint"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pps']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pps']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ppsm
      Script MimeTypeppsm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ppsm"
                  mimeType = "application/vnd.ms-powerpoint.slideshow.macroEnabled.12"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ppsm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ppsm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ppsx
      Script MimeTypeppsx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ppsx"
                  mimeType = "application/vnd.openxmlformats-officedocument.presentationml.slideshow"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ppsx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ppsx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ppt
      Script MimeTypeppt {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ppt"
                  mimeType = "application/vnd.ms-powerpoint"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ppt']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ppt']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pptm
      Script MimeTypepptm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pptm"
                  mimeType = "application/vnd.ms-powerpoint.presentation.macroEnabled.12"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pptm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pptm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pptx
      Script MimeTypepptx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pptx"
                  mimeType = "application/vnd.openxmlformats-officedocument.presentationml.presentation"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pptx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pptx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .prf
      Script MimeTypeprf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".prf"
                  mimeType = "application/pics-rules"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.prf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.prf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .prm
      Script MimeTypeprm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".prm"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.prm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.prm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .prx
      Script MimeTypeprx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".prx"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.prx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.prx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ps
      Script MimeTypeps {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ps"
                  mimeType = "application/postscript"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ps']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ps']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .psd
      Script MimeTypepsd {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".psd"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.psd']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.psd']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .psm
      Script MimeTypepsm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".psm"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.psm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.psm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .psp
      Script MimeTypepsp {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".psp"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.psp']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.psp']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .pub
      Script MimeTypepub {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".pub"
                  mimeType = "application/x-mspublisher"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pub']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.pub']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .qt
      Script MimeTypeqt {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".qt"
                  mimeType = "video/quicktime"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.qt']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.qt']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .qtl
      Script MimeTypeqtl {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".qtl"
                  mimeType = "application/x-quicktimeplayer"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.qtl']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.qtl']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .qxd
      Script MimeTypeqxd {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".qxd"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.qxd']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.qxd']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ra
      Script MimeTypera {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ra"
                  mimeType = "audio/x-pn-realaudio"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ra']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ra']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ram
      Script MimeTyperam {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ram"
                  mimeType = "audio/x-pn-realaudio"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ram']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ram']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .rar
      Script MimeTyperar {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".rar"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.rar']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.rar']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ras
      Script MimeTyperas {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ras"
                  mimeType = "image/x-cmu-raster"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ras']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ras']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .rf
      Script MimeTyperf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".rf"
                  mimeType = "image/vnd.rn-realflash"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.rf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.rf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .rgb
      Script MimeTypergb {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".rgb"
                  mimeType = "image/x-rgb"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.rgb']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.rgb']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .rm
      Script MimeTyperm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".rm"
                  mimeType = "application/vnd.rn-realmedia"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.rm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.rm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .rmi
      Script MimeTypermi {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".rmi"
                  mimeType = "audio/mid"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.rmi']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.rmi']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .roff
      Script MimeTyperoff {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".roff"
                  mimeType = "application/x-troff"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.roff']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.roff']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .rpm
      Script MimeTyperpm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".rpm"
                  mimeType = "audio/x-pn-realaudio-plugin"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.rpm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.rpm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .rtf
      Script MimeTypertf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".rtf"
                  mimeType = "application/rtf"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.rtf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.rtf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .rtx
      Script MimeTypertx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".rtx"
                  mimeType = "text/richtext"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.rtx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.rtx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .scd
      Script MimeTypescd {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".scd"
                  mimeType = "application/x-msschedule"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.scd']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.scd']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .sct
      Script MimeTypesct {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".sct"
                  mimeType = "text/scriptlet"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sct']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sct']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .sea
      Script MimeTypesea {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".sea"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sea']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sea']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .setpay
      Script MimeTypesetpay {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".setpay"
                  mimeType = "application/set-payment-initiation"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.setpay']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.setpay']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .setreg
      Script MimeTypesetreg {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".setreg"
                  mimeType = "application/set-registration-initiation"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.setreg']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.setreg']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .sgml
      Script MimeTypesgml {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".sgml"
                  mimeType = "text/sgml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sgml']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sgml']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .sh
      Script MimeTypesh {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".sh"
                  mimeType = "application/x-sh"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sh']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sh']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .shar
      Script MimeTypeshar {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".shar"
                  mimeType = "application/x-shar"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.shar']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.shar']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .sit
      Script MimeTypesit {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".sit"
                  mimeType = "application/x-stuffit"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sit']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sit']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .sldm
      Script MimeTypesldm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".sldm"
                  mimeType = "application/vnd.ms-powerpoint.slide.macroEnabled.12"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sldm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sldm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .sldx
      Script MimeTypesldx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".sldx"
                  mimeType = "application/vnd.openxmlformats-officedocument.presentationml.slide"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sldx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sldx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .smd
      Script MimeTypesmd {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".smd"
                  mimeType = "audio/x-smd"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.smd']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.smd']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .smi
      Script MimeTypesmi {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".smi"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.smi']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.smi']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .smx
      Script MimeTypesmx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".smx"
                  mimeType = "audio/x-smd"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.smx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.smx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .smz
      Script MimeTypesmz {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".smz"
                  mimeType = "audio/x-smd"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.smz']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.smz']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .snd
      Script MimeTypesnd {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".snd"
                  mimeType = "audio/basic"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.snd']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.snd']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .snp
      Script MimeTypesnp {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".snp"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.snp']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.snp']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .spc
      Script MimeTypespc {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".spc"
                  mimeType = "application/x-pkcs7-certificates"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.spc']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.spc']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .spl
      Script MimeTypespl {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".spl"
                  mimeType = "application/futuresplash"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.spl']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.spl']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .spx
      Script MimeTypespx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".spx"
                  mimeType = "audio/ogg"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.spx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.spx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .src
      Script MimeTypesrc {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".src"
                  mimeType = "application/x-wais-source"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.src']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.src']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ssm
      Script MimeTypessm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ssm"
                  mimeType = "application/streamingmedia"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ssm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ssm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .sst
      Script MimeTypesst {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".sst"
                  mimeType = "application/vnd.ms-pki.certstore"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sst']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sst']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .stl
      Script MimeTypestl {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".stl"
                  mimeType = "application/vnd.ms-pki.stl"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.stl']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.stl']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .sv4cpio
      Script MimeTypesv4cpio {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".sv4cpio"
                  mimeType = "application/x-sv4cpio"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sv4cpio']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sv4cpio']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .sv4crc
      Script MimeTypesv4crc {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".sv4crc"
                  mimeType = "application/x-sv4crc"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sv4crc']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.sv4crc']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .svg
      Script MimeTypesvg {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".svg"
                  mimeType = "image/svg+xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.svg']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.svg']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .svgz
      Script MimeTypesvgz {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".svgz"
                  mimeType = "image/svg+xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.svgz']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.svgz']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .swf
      Script MimeTypeswf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".swf"
                  mimeType = "application/x-shockwave-flash"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.swf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.swf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .t
      Script MimeTypet {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".t"
                  mimeType = "application/x-troff"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.t']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.t']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .tar
      Script MimeTypetar {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".tar"
                  mimeType = "application/x-tar"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.tar']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.tar']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .tcl
      Script MimeTypetcl {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".tcl"
                  mimeType = "application/x-tcl"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.tcl']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.tcl']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .tex
      Script MimeTypetex {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".tex"
                  mimeType = "application/x-tex"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.tex']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.tex']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .texi
      Script MimeTypetexi {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".texi"
                  mimeType = "application/x-texinfo"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.texi']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.texi']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .texinfo
      Script MimeTypetexinfo {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".texinfo"
                  mimeType = "application/x-texinfo"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.texinfo']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.texinfo']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .tgz
      Script MimeTypetgz {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".tgz"
                  mimeType = "application/x-compressed"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.tgz']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.tgz']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .thmx
      Script MimeTypethmx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".thmx"
                  mimeType = "application/vnd.ms-officetheme"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.thmx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.thmx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .thn
      Script MimeTypethn {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".thn"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.thn']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.thn']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .tif
      Script MimeTypetif {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".tif"
                  mimeType = "image/tiff"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.tif']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.tif']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .tiff
      Script MimeTypetiff {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".tiff"
                  mimeType = "image/tiff"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.tiff']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.tiff']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .toc
      Script MimeTypetoc {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".toc"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.toc']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.toc']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .tr
      Script MimeTypetr {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".tr"
                  mimeType = "application/x-troff"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.tr']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.tr']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .trm
      Script MimeTypetrm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".trm"
                  mimeType = "application/x-msterminal"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.trm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.trm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ts
      Script MimeTypets {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ts"
                  mimeType = "video/vnd.dlna.mpeg-tts"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ts']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ts']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .tsv
      Script MimeTypetsv {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".tsv"
                  mimeType = "text/tab-separated-values"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.tsv']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.tsv']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ttf
      Script MimeTypettf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ttf"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ttf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ttf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .tts
      Script MimeTypetts {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".tts"
                  mimeType = "video/vnd.dlna.mpeg-tts"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.tts']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.tts']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .u32
      Script MimeTypeu32 {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".u32"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.u32']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.u32']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .uls
      Script MimeTypeuls {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".uls"
                  mimeType = "text/iuls"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.uls']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.uls']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .ustar
      Script MimeTypeustar {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".ustar"
                  mimeType = "application/x-ustar"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ustar']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.ustar']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .vbs
      Script MimeTypevbs {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".vbs"
                  mimeType = "text/vbscript"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vbs']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vbs']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .vcf
      Script MimeTypevcf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".vcf"
                  mimeType = "text/x-vcard"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vcf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vcf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .vcs
      Script MimeTypevcs {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".vcs"
                  mimeType = "text/plain"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vcs']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vcs']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .vdx
      Script MimeTypevdx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".vdx"
                  mimeType = "application/vnd.ms-visio.viewer"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vdx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vdx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .vml
      Script MimeTypevml {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".vml"
                  mimeType = "text/xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vml']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vml']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .vsd
      Script MimeTypevsd {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".vsd"
                  mimeType = "application/vnd.visio"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vsd']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vsd']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .vss
      Script MimeTypevss {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".vss"
                  mimeType = "application/vnd.visio"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vss']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vss']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .vst
      Script MimeTypevst {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".vst"
                  mimeType = "application/vnd.visio"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vst']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vst']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .vsto
      Script MimeTypevsto {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".vsto"
                  mimeType = "application/x-ms-vsto"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vsto']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vsto']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .vsw
      Script MimeTypevsw {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".vsw"
                  mimeType = "application/vnd.visio"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vsw']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vsw']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .vsx
      Script MimeTypevsx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".vsx"
                  mimeType = "application/vnd.visio"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vsx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vsx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .vtx
      Script MimeTypevtx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".vtx"
                  mimeType = "application/vnd.visio"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vtx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.vtx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wasm
      Script MimeTypewasm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wasm"
                  mimeType = "application/wasm"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wasm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wasm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wav
      Script MimeTypewav {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wav"
                  mimeType = "audio/wav"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wav']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wav']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wax
      Script MimeTypewax {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wax"
                  mimeType = "audio/x-ms-wax"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wax']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wax']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wbmp
      Script MimeTypewbmp {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wbmp"
                  mimeType = "image/vnd.wap.wbmp"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wbmp']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wbmp']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wcm
      Script MimeTypewcm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wcm"
                  mimeType = "application/vnd.ms-works"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wcm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wcm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wdb
      Script MimeTypewdb {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wdb"
                  mimeType = "application/vnd.ms-works"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wdb']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wdb']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .webm
      Script MimeTypewebm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".webm"
                  mimeType = "video/webm"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.webm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.webm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wks
      Script MimeTypewks {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wks"
                  mimeType = "application/vnd.ms-works"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wks']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wks']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wm
      Script MimeTypewm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wm"
                  mimeType = "video/x-ms-wm"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wma
      Script MimeTypewma {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wma"
                  mimeType = "audio/x-ms-wma"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wma']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wma']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wmd
      Script MimeTypewmd {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wmd"
                  mimeType = "application/x-ms-wmd"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wmd']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wmd']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wmf
      Script MimeTypewmf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wmf"
                  mimeType = "application/x-msmetafile"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wmf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wmf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wml
      Script MimeTypewml {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wml"
                  mimeType = "text/vnd.wap.wml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wml']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wml']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wmlc
      Script MimeTypewmlc {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wmlc"
                  mimeType = "application/vnd.wap.wmlc"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wmlc']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wmlc']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wmls
      Script MimeTypewmls {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wmls"
                  mimeType = "text/vnd.wap.wmlscript"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wmls']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wmls']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wmlsc
      Script MimeTypewmlsc {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wmlsc"
                  mimeType = "application/vnd.wap.wmlscriptc"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wmlsc']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wmlsc']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wmp
      Script MimeTypewmp {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wmp"
                  mimeType = "video/x-ms-wmp"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wmp']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wmp']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wmv
      Script MimeTypewmv {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wmv"
                  mimeType = "video/x-ms-wmv"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wmv']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wmv']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wmx
      Script MimeTypewmx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wmx"
                  mimeType = "video/x-ms-wmx"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wmx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wmx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wmz
      Script MimeTypewmz {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wmz"
                  mimeType = "application/x-ms-wmz"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wmz']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wmz']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .woff
      Script MimeTypewoff {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".woff"
                  mimeType = "font/x-woff"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.woff']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.woff']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .woff2
      Script MimeTypewoff2 {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".woff2"
                  mimeType = "application/font-woff2"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.woff2']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.woff2']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wps
      Script MimeTypewps {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wps"
                  mimeType = "application/vnd.ms-works"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wps']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wps']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wri
      Script MimeTypewri {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wri"
                  mimeType = "application/x-mswrite"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wri']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wri']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wrl
      Script MimeTypewrl {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wrl"
                  mimeType = "x-world/x-vrml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wrl']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wrl']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wrz
      Script MimeTypewrz {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wrz"
                  mimeType = "x-world/x-vrml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wrz']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wrz']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wsdl
      Script MimeTypewsdl {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wsdl"
                  mimeType = "text/xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wsdl']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wsdl']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wtv
      Script MimeTypewtv {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wtv"
                  mimeType = "video/x-ms-wtv"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wtv']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wtv']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .wvx
      Script MimeTypewvx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".wvx"
                  mimeType = "video/x-ms-wvx"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wvx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.wvx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .x
      Script MimeTypex {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".x"
                  mimeType = "application/directx"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.x']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.x']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xaf
      Script MimeTypexaf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xaf"
                  mimeType = "x-world/x-vrml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xaf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xaf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xaml
      Script MimeTypexaml {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xaml"
                  mimeType = "application/xaml+xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xaml']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xaml']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xap
      Script MimeTypexap {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xap"
                  mimeType = "application/x-silverlight-app"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xap']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xap']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xbap
      Script MimeTypexbap {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xbap"
                  mimeType = "application/x-ms-xbap"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xbap']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xbap']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xbm
      Script MimeTypexbm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xbm"
                  mimeType = "image/x-xbitmap"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xbm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xbm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xdr
      Script MimeTypexdr {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xdr"
                  mimeType = "text/plain"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xdr']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xdr']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xht
      Script MimeTypexht {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xht"
                  mimeType = "application/xhtml+xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xht']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xht']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xhtml
      Script MimeTypexhtml {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xhtml"
                  mimeType = "application/xhtml+xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xhtml']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xhtml']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xla
      Script MimeTypexla {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xla"
                  mimeType = "application/vnd.ms-excel"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xla']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xla']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xlam
      Script MimeTypexlam {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xlam"
                  mimeType = "application/vnd.ms-excel.addin.macroEnabled.12"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xlam']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xlam']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xlc
      Script MimeTypexlc {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xlc"
                  mimeType = "application/vnd.ms-excel"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xlc']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xlc']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xlm
      Script MimeTypexlm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xlm"
                  mimeType = "application/vnd.ms-excel"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xlm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xlm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xls
      Script MimeTypexls {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xls"
                  mimeType = "application/vnd.ms-excel"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xls']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xls']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xlsb
      Script MimeTypexlsb {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xlsb"
                  mimeType = "application/vnd.ms-excel.sheet.binary.macroEnabled.12"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xlsb']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xlsb']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xlsm
      Script MimeTypexlsm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xlsm"
                  mimeType = "application/vnd.ms-excel.sheet.macroEnabled.12"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xlsm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xlsm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xlsx
      Script MimeTypexlsx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xlsx"
                  mimeType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xlsx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xlsx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xlt
      Script MimeTypexlt {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xlt"
                  mimeType = "application/vnd.ms-excel"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xlt']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xlt']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xltm
      Script MimeTypexltm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xltm"
                  mimeType = "application/vnd.ms-excel.template.macroEnabled.12"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xltm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xltm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xltx
      Script MimeTypexltx {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xltx"
                  mimeType = "application/vnd.openxmlformats-officedocument.spreadsheetml.template"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xltx']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xltx']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xlw
      Script MimeTypexlw {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xlw"
                  mimeType = "application/vnd.ms-excel"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xlw']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xlw']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xml
      Script MimeTypexml {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xml"
                  mimeType = "text/xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xml']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xml']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xof
      Script MimeTypexof {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xof"
                  mimeType = "x-world/x-vrml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xof']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xof']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xpm
      Script MimeTypexpm {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xpm"
                  mimeType = "image/x-xpixmap"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xpm']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xpm']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xps
      Script MimeTypexps {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xps"
                  mimeType = "application/vnd.ms-xpsdocument"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xps']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xps']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xsd
      Script MimeTypexsd {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xsd"
                  mimeType = "text/xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xsd']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xsd']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xsf
      Script MimeTypexsf {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xsf"
                  mimeType = "text/xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xsf']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xsf']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xsl
      Script MimeTypexsl {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xsl"
                  mimeType = "text/xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xsl']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xsl']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xslt
      Script MimeTypexslt {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xslt"
                  mimeType = "text/xml"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xslt']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xslt']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xsn
      Script MimeTypexsn {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xsn"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xsn']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xsn']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xtp
      Script MimeTypextp {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xtp"
                  mimeType = "application/octet-stream"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xtp']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xtp']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .xwd
      Script MimeTypexwd {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".xwd"
                  mimeType = "image/x-xwindowdump"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xwd']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.xwd']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .z
      Script MimeTypez {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".z"
                  mimeType = "application/x-compress"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.z']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.z']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
      # Custom MIME Type: .zip
      Script MimeTypezip {
          SetScript = {
              Add-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent" -Name "." -Value @{
                  fileExtension = ".zip"
                  mimeType = "application/x-zip-compressed"
              }
          }
          TestScript = {
               = Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.zip']" -Name "."
              return  -ne 
          }
          GetScript = {
              return @{
                  Result = (Get-WebConfigurationProperty -PSPath 'IIS:\' -Filter "//staticContent/mimeMap[@fileExtension='.zip']" -Name ".") -ne 
              }
          }
          DependsOn = "[WindowsFeature]IIS"
      }
  }
}
