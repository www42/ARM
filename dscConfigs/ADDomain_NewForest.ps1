Configuration ADDomain_NewForest
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $DomainName
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName ActiveDirectoryDsc

    $AdminName = 'Administrator'
    $SecurePW = ConvertTo-SecureString -String 'Pa55w.rd1234' -AsPlainText -Force
    $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $AdminName,$SecurePW
    $SafeModePassword = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $AdminName,$SecurePW

    node 'localhost'
    {
        WindowsFeature 'ADDS'
        {
            Name   = 'AD-Domain-Services'
            Ensure = 'Present'
        }

        WindowsFeature 'RSAT'
        {
            Name   = 'RSAT-AD-Tools'
            Ensure = 'Present'
        }

        ADDomain 'contoso.com'
        {
            DomainName                    = $DomainName
            Credential                    = $Credential
            SafemodeAdministratorPassword = $SafeModePassword
            ForestMode                    = 'WinThreshold'
        }
    }
}