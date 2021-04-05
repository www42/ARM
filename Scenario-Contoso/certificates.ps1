$GatewayName = "Contoso-Gateway"
$RgName = "Contoso-RG"
$RootCertificateName="ContosoRootCertificate"
$ClientCertificateName="ContosoClientCertificate"
$PfxPassword = 'Pa55w.rd1234'

# 1. Root Certificate
# -------------------
$RootCertificate = New-SelfSignedCertificate `
    -FriendlyName $RootCertificateName `
    -Subject "CN=$RootCertificateName" `
    -Type Custom `
    -KeySpec Signature `
    -KeyExportPolicy Exportable `
    -HashAlgorithm sha256 `
    -KeyLength 2048 `
    -KeyUsageProperty Sign `
    -KeyUsage CertSign `
    -CertStoreLocation 'Cert:\CurrentUser\My'

# Public certificate data to be uploaded to gateway
$RootCertPublicData=[System.Convert]::ToBase64String($RootCertificate.RawData)

# There are several ways to upload
#   a) Upload by CLI
az network vnet-gateway root-cert create `
    --name $RootCertificateName `
    --public-cert-data $RootCertPublicData `
    --gateway-name $GatewayName  --resource-group $RgName

#   b) Copy/paste to ARM template
$RootCertPublicData | clip 

# Let's export Root cert
$Pass = ConvertTo-SecureString -String $PfxPassword -AsPlainText -Force
$RootCertificate | Export-PfxCertificate -FilePath ./$RootCertificateName.pfx -Password $Pass

# Remove root cert (We have a pfx exported) 
Remove-Item -Path $RootCertificate.PSPath

# 2. Client Certificate
# ---------------------

# Import Root cert
$RootCertificate = Import-PfxCertificate -FilePath ./$RootCertificateName.pfx -CertStoreLocation 'Cert:\CurrentUser\My' -Exportable -Password $Pass

# Create client cert
$ClientCertificate = New-SelfSignedCertificate `
    -FriendlyName $ClientCertificateName `
    -Subject "CN=$ClientCertificateName" `
    -Type Custom `
    -KeySpec Signature `
    -KeyExportPolicy Exportable `
    -HashAlgorithm sha256 `
    -KeyLength 2048 `
    -Signer $RootCertificate `
    -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2") `
    -CertStoreLocation 'Cert:\CurrentUser\My'
    
Get-ChildItem Cert:\CurrentUser\My | 
    where {$_.Subject -eq "CN=$RootCertificateName" -or $_.Subject -eq "CN=$ClientCertificateName"} | 
    ft Subject, Issuer, Thumbprint


# 3. VPN client
# --------------

# Download VPN client
$Uri=az network vnet-gateway vpn-client generate `
    --processor-architecture Amd64 `
    --name $GatewayName --resource-group $RgName `
    --output tsv

$VpnZipPath="$env:HOMEPATH\Downloads"

Invoke-RestMethod -Uri $Uri -OutFile $VpnZipPath\VpnClient.zip

Expand-Archive -Path $VpnZipPath\VpnClient.zip -DestinationPath $VpnZipPath\VpnClient

# Install VPN client manually
& $VpnZipPath\VpnClient\WindowsAmd64\VpnClientSetupAmd64.exe

# Connect
cmd.exe /C "start ms-settings:network-vpn"

# Test connectivity
Get-NetIPConfiguration | where InterfaceAlias -eq 'Hub'
Test-NetConnection 10.0.0.4 -Traceroute
Test-NetConnection 10.0.1.4 -Traceroute
Test-NetConnection 10.0.4.4 -Traceroute

# Clean up
# --------
Remove-Item -Path $RootCertificate.PSPath
Remove-Item -Path $ClientCertificate.PSPath
    