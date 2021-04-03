$GatewayName = "Contoso-Gateway"
$RgName = "Contoso-RG"
$RootCertificateName="ContosoRootCertificate"
$ClientCertificateName="ContosoClientCertificate"
$PfxPassword = 'Pa55w.rd1234'

# Root Certificate
# ----------------
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

# Client Certificate
# ------------------
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
    
    
    
    
# Clean up
Get-ChildItem Cert:\CurrentUser\My | 
    where {$_.Subject -eq "CN=$RootCertificateName" -or $_.Subject -eq "CN=$ClientCertificateName"} | 
    ft Subject, Issuer, Thumbprint

Remove-Item -Path $RootCertificate.PSPath
Remove-Item -Path $ClientCertificate.PSPath
    