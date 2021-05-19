# MSDN-Plattformen  Paul@az.training
# Subscription ID:  ffcb38a5-8428-40c4-98b7-77013eac7ec5
# Tenant ID:        819ebf55-0973-4703-b006-581a48f25961

# Azure Pass        Paul@adatum30304.onmicrosoft.com
# Subscription ID:  26994ff8-a16e-48ed-9eca-8597519aaa5c
# Tenant ID:        308e6bd8-bcd8-4594-a170-0bfbdebdab01

Logout-AzAccount
Login-AzAccount

Get-AzContext | fl
Get-AzSubscription | ft Name,Id,State

$subscriptionId = '6d8a949f-78ab-45f4-909a-1a97c83b5735'
Set-AzContext -Subscription $subscriptionId

Get-AzContext | fl Account,Subscription,Tenant

Get-AzResourceGroup | Sort-Object ResourceGroupName | ft ResourceGroupName,Location,ProvisioningState