Configuration ADDomain_NewForest_Config
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName ActiveDirectoryDsc

    $Credential = ConvertTo-SecureString -String 'Pa55w.rd1234' -AsPlainText -Force
    $SafeModePassword = ConvertTo-SecureString -String 'Pa55w.rd1234' -AsPlainText -Force
    
    node 'localhost'
    {
        WindowsFeature 'ADDS'
        {
            Name   = 'AD-Domain-Services'
            Ensure = 'Present'
        }

        WindowsFeature 'RSAT'
        {
            Name   = 'RSAT-AD-PowerShell'
            Ensure = 'Present'
        }

        ADDomain 'contoso.com'
        {
            DomainName                    = 'contoso.com'
            Credential                    = $Credential
            SafemodeAdministratorPassword = $SafeModePassword
            ForestMode                    = 'WinThreshold'
        }
    }
}