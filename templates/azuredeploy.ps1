# Login to Azure
# --------------
Connect-AzAccount
Get-AzContext | fl


$Location = "westeurope"
$RgName = "RG-PS61"

New-AzResourceGroup -Name $RgName -Location $Location

$Template = "https://raw.githubusercontent.com/www42/arm/master/templates/ps-61.json"
New-AzResourceGroupDeployment -ResourceGroupName $RgName -TemplateUri $Template