# AzureAD Connect installs two PowerShell modules:
#       ADSync
#       MSOnline
#
#   ADSync --> Connectors, Scheduler, SyncCycl etc
#   -----------------------------------------------
Get-Module -Name ADSync -ListAvailable

Get-ADSyncAADCompanyFeature
Get-ADSyncConnector | ft Name,Type
Get-ADSyncScheduler
Start-ADSyncSyncCycle -PolicyType Delta

#   MSOnline --> Stop Sync
#   ----------------------
Get-Module    -Name "C:\Program Files\Microsoft Azure Active Directory Connect\AADPowerShell\MSOnline.psd1" -ListAvailable
Import-Module -Name "C:\Program Files\Microsoft Azure Active Directory Connect\AADPowerShell\MSOnline.psd1"

Connect-MsolService
Set-MsolDirSyncEnabled -EnableDirSync $false -Force
Get-MsolCompanyInformation | fl DirectorySynchronizationEnabled,LastDirSyncTime,LastPasswordSyncTime
