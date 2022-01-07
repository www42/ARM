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
# on DC1
# Get-Module    -Name "C:\Program Files\Microsoft Azure Active Directory Connect\AADPowerShell\MSOnline.psd1" -ListAvailable
# Import-Module -Name "C:\Program Files\Microsoft Azure Active Directory Connect\AADPowerShell\MSOnline.psd1"
Get-Module -ListAvailable -Name MSOnline

Connect-MsolService
Set-MsolDirSyncEnabled -EnableDirSync $false -Force
Get-MsolCompanyInformation | fl DirectorySynchronizationEnabled,LastDirSyncTime,LastPasswordSyncTime
