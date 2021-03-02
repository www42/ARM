# MSDN-Plattformen  Paul@az.training
# Subscription ID:  ffcb38a5-8428-40c4-98b7-77013eac7ec5
# Tenant ID:        819ebf55-0973-4703-b006-581a48f25961

# Azure Pass        Paul@adatum6404.onmicrosoft.com
# Subscription ID:  c46281f7-38b7-4e1d-ba22-140cd892cd07
# Tenant ID:        89ee3811-46d2-4152-af70-352fcce4d323

Logout-AzAccount
Login-AzAccount

Get-AzContext | fl
Get-AzSubscription | ft Name,Id,State

$subscriptionId = 'c46281f7-38b7-4e1d-ba22-140cd892cd07'
Set-AzContext -Subscription $subscriptionId

Get-AzContext | fl Account,Subscription,Tenant

Get-AzResourceGroup | Sort-Object ResourceGroupName | ft ResourceGroupName,Location,ProvisioningState