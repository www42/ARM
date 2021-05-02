Configuration InstallRRAS-PrettyWindows {
   node ("localhost") {
      WindowsFeature RemoteAccess {
           Ensure = "Present"
           Name   = "RemoteAccess"
        }
      WindowsFeature RSAT-RemoteAccess {
           Ensure = "Present"
           Name   = "RSAT-RemoteAccess"
        }
      WindowsFeature Routing {
           Ensure = "Present"
           Name   = "Routing"
        }
      Registry NoFirewallDomain {
         Ensure    = "Present"
         Key       = "HKLM:\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile"
         ValueName = "EnableFirewall"
         ValueType = "Dword"
         ValueData = [int]0
     }
      Registry NoFirewallPrivate {
         Ensure    = "Present"
         Key       = "HKLM:\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile"
         ValueName = "EnableFirewall"
         ValueType = "Dword"
         ValueData = [int]0
     }
      Registry NoFirewallPublic {
         Ensure    = "Present"
         Key       = "HKLM:\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile"
         ValueName = "EnableFirewall"
         ValueType = "Dword"
         ValueData = [int]0
     }
      Registry NoIeSecurityAdmin {
         Ensure    = "Present"
         Key       = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
         ValueName = "IsInstalled"
         ValueType = "Dword"
         ValueData = [int]0
     }
      Registry NoIEenhancedSecurityUser {
         Ensure    = "Present"
         Key       = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
         ValueName = "IsInstalled"
         ValueType = "Dword"
         ValueData = [int]0
     }
      Registry NoPopupTryWAC {
         Ensure    = "Present"
         Key       = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager"
         ValueName = "DoNotPopWACConsoleAtSMLaunch"
         ValueType = "Dword"
         ValueData = [int]1
     }
  }
}
Configuration PrettyWindows {
   node ("localhost") {
      Registry NoFirewallDomain {
           Ensure    = "Present"
           Key       = "HKLM:\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile"
           ValueName = "EnableFirewall"
           ValueType = "Dword"
           ValueData = [int]0
       }
      Registry NoFirewallPrivate {
           Ensure    = "Present"
           Key       = "HKLM:\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile"
           ValueName = "EnableFirewall"
           ValueType = "Dword"
           ValueData = [int]0
       }
      Registry NoFirewallPublic {
           Ensure    = "Present"
           Key       = "HKLM:\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile"
           ValueName = "EnableFirewall"
           ValueType = "Dword"
           ValueData = [int]0
       }
      Registry NoIeSecurityAdmin {
           Ensure    = "Present"
           Key       = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
           ValueName = "IsInstalled"
           ValueType = "Dword"
           ValueData = [int]0
       }
      Registry NoIEenhancedSecurityUser {
           Ensure    = "Present"
           Key       = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
           ValueName = "IsInstalled"
           ValueType = "Dword"
           ValueData = [int]0
       }
      Registry NoPopupTryWAC {
           Ensure    = "Present"
           Key       = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager"
           ValueName = "DoNotPopWACConsoleAtSMLaunch"
           ValueType = "Dword"
           ValueData = [int]1
       }
   }
}