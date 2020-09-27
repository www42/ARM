Connect-AzAccount
Get-AzContext | fl

$location = "westus"
$rgName = "PS61-RG"
$automationAccountName = 'PS61-Automation'

Get-AzResourceGroup -Name $rgName
Get-AzResource -ResourceGroupName $rgName | Sort-Object ResourceType | Format-Table Name,ResourceType

# ----- Deployments -----
Get-AzResourceGroupDeployment -ResourceGroupName $rgName | Sort-Object Timestamp -Descending | Format-Table DeploymentName,ProvisioningState,Timestamp

# ----- Azure Automation Account -----
Get-AzAutomationAccount -Name $automationAccountName -ResourceGroupName $rgName
Get-AzAutomationModule -AutomationAccountName $automationAccountName -ResourceGroupName $rgName | Format-Table Name,Version,IsGlobal,AutomationAccountName
Get-AzAutomationDscConfiguration -AutomationAccountName $automationAccountName -ResourceGroupName $rgName | Format-Table AutomationAccountName,Name,State
Get-AzAutomationDscCompilationJob -AutomationAccountName $automationAccountName -ResourceGroupName $rgName | Format-Table ConfigurationName,JobParameters,Status
Get-AzAutomationRegistrationInfo -AutomationAccountName $automationAccountName -ResourceGroupName $rgName