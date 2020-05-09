Connect-AzAccount
Get-AzContext | fl

$location = "westeurope"
$rgName = "PS61-RG"

Get-AzResourceGroup | ft ResourceGroupName, Location, ResourceId
New-AzResourceGroup -Name $rgName -Location $location


 
#--- Deploy with Template URI ----------------------------------------------------------------
$template = "https://raw.githubusercontent.com/www42/arm/master/templates/automationAccount.json"
$automationAccountName = "foo9-Automation"
$deploymentName = "sun09"
New-AzResourceGroupDeployment `
-ResourceGroupName $rgName `
-Name $deploymentName `
-TemplateUri $template `
-TemplateParameterObject @{automationAccountName="$automationAccountName"}

#--- Deploy with Template File ---------------------------------------------------------------
$file = "./templates/automationAccount.json"
$automationAccountName = "foo8-Automation"
$deploymentName = "sun08"
New-AzResourceGroupDeployment `
    -ResourceGroupName $rgName `
    -Name $deploymentName `
    -TemplateFile $file `
    -TemplateParameterObject @{automationAccountName="$automationAccountName"}

Get-AzResourceGroupDeployment -ResourceGroupName $rgName | Sort-Object Timestamp | ft DeploymentName, ProvisioningState, Timestamp

Get-AzAutomationAccount | ft AutomationAccountName, ResourceGroupName, Location
Get-AzAutomationDscConfiguration -ResourceGroupName $rgName -AutomationAccountName $automationAccountName | ft AutomationAccountName, Name, State
Get-AzAutomationDscCompilationJob -ResourceGroupName $rgName -AutomationAccountName $automationAccountName
Get-AzAutomationModule -ResourceGroupName $rgName -AutomationAccountName $automationAccountName | ft Name, Version, IsGlobal, AutomationAccountName



Get-AzAutomationRegistrationInfo -ResourceGroupName $rgName -AutomationAccountName $automationAccountName
(Get-AzAutomationRegistrationInfo -ResourceGroupName $rgName -AutomationAccountName $automationAccountName).Endpoint
(Get-AzAutomationRegistrationInfo -ResourceGroupName $rgName -AutomationAccountName $automationAccountName).PrimaryKey