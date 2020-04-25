Connect-AzAccount
Get-AzContext | fl

$location = "westeurope"
$rgName = "PS61-RG"

Get-AzResourceGroup | ft ResourceGroupName, Location, ResourceId
New-AzResourceGroup -Name $rgName -Location $location


 # DSC stuff
# -------------------------------------------------------------------

$rgName = "fo-RG"
$template = "https://raw.githubusercontent.com/www42/arm/master/templates/automationAccount.json"
$automationAccountName = "foo43-Automation"
$deploymentName = "sat04"
New-AzResourceGroupDeployment `
    -ResourceGroupName $rgName `
    -Name $deploymentName `
    -TemplateUri $template `
    -TemplateParameterObject @{automationAccountName="$automationAccountName"}


Get-AzAutomationAccount 
Get-AzAutomationAccount | ft AutomationAccountName, ResourceGroupName, Location


Get-AzAutomationRegistrationInfo -ResourceGroupName $rgName -AutomationAccountName $automationAccountName
(Get-AzAutomationRegistrationInfo -ResourceGroupName $rgName -AutomationAccountName $automationAccountName).Endpoint
(Get-AzAutomationRegistrationInfo -ResourceGroupName $rgName -AutomationAccountName $automationAccountName).PrimaryKey