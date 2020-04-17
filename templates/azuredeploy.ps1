# Login to Azure
# --------------
Connect-AzAccount
Get-AzContext | fl


$location = "westeurope"
$rgName = "RG-PS61"

New-AzResourceGroup -Name $rgName -Location $location

$template = "https://raw.githubusercontent.com/www42/arm/master/templates/ps-61.json"
New-AzResourceGroupDeployment -ResourceGroupName $rgName -TemplateUri $template