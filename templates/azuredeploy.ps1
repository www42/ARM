# Login to Azure
# --------------
Connect-AzAccount
Get-AzContext | fl


$location = "westeurope"
$rgName = "PS61-RG"

New-AzResourceGroup -Name $rgName -Location $location
Get-AzResourceGroup 

$template = "https://raw.githubusercontent.com/www42/arm/master/templates/ps-61.json"
New-AzResourceGroupDeployment -ResourceGroupName $rgName -TemplateUri $template

# DSC
# ---
Get-AzAutomationAccount 
$automationAccountName = "PS61-Automation"

Get-AzAutomationRegistrationInfo -ResourceGroupName $rgName -AutomationAccountName $automationAccountName
(Get-AzAutomationRegistrationInfo -ResourceGroupName $rgName -AutomationAccountName $automationAccountName).Endpoint
(Get-AzAutomationRegistrationInfo -ResourceGroupName $rgName -AutomationAccountName $automationAccountName).PrimaryKey