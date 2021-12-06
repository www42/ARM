$Abteilung = "Production"
$OUName = $Abteilung
$SeurePW = ConvertTo-SecureString -String 'Pa55w.rd1234' -AsPlainText -Force

New-ADOrganizationalUnit -Name $OUName

$OUPath = Get-ADOrganizationalUnit -Filter {Name -eq $OUName} | select -ExpandProperty DistinguishedName
$DomainSuffix = Get-ADDomain | select -ExpandProperty DNSRoot

New-ADGroup -GroupScope Global -Name $Abteilung -Path $OUPath

for ($i = 6; $i -le 10; $i++)
{  
  $Name = "$Abteilung$i"
  New-ADUser `
    -Name $Name -SamAccountName $Name -DisplayName $Name `
    -AccountPassword $SeurePW -ChangePasswordAtLogon $false  `
    -Path  $OUPath `
    -Enabled $true

  Add-ADGroupMember -Identity $Abteilung -Members $Name
}


Add-ADGroupMember "Domain Admins" "TestUser";
