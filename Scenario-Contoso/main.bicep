targetScope = 'subscription'

param rgName string = 'Contoso-RG'

var vnetHubAddressSpace           = '172.16.0.0/16'
var vnetHubSubnetAddressPrefix    = '172.16.0.0/24'
var gatewaySubnetPrefix           = '172.16.255.0/27'
//var foo                           = 'networkDeploy.outputs.hubName'

var vnetSpoke1AddressSpace        = '172.17.0.0/16'
var vnetSpoke1SubnetAddressPrefix = '172.17.0.0/24'
var vmDcIp                        = '172.17.0.200'
//var bastionVnetName               = 'networkDeploy.outputs.spoke1Name'
var bastionSubnetPrefix           = '172.17.255.0/27'

var vnetSpoke2AddressSpace        = '172.18.0.0/16'
var vnetSpoke2SubnetAddressPrefix = '172.18.0.0/24'

resource rg 'Microsoft.Resources/resourceGroups@2020-10-01' = {
  name: rgName
  location: deployment().location
}
module networkDeploy 'network.bicep' = {
  name: 'networkDeploy'
  scope: rg
  params: {
    vnetHubAddressSpace: vnetHubAddressSpace
    vnetHubSubnetAddressPrefix: vnetHubSubnetAddressPrefix
    vnetSpoke1AddressSpace: vnetSpoke1AddressSpace
    vnetSpoke1SubnetAddressPrefix: vnetSpoke1SubnetAddressPrefix
    vnetSpoke2AddressSpace: vnetSpoke2AddressSpace
    vnetSpoke2SubnetAddressPrefix: vnetSpoke2SubnetAddressPrefix
  }
}
module bastionDeploy 'bastion.bicep' = {
  name: 'bastionDeploy'
  scope: rg
  params: {
    //vnetName: bastionVnetName
    vnetName: networkDeploy.outputs.spoke1Name
    bastionSubnetPrefix: bastionSubnetPrefix
  }
}
module automationDeploy 'automation.bicep' = {
  name: 'automationDeploy'
  scope: rg
  params: {
    aaName: 'Contoso-Automation'
  }
}
module dcDeploy 'dc.bicep' = {
  name: 'dcDeploy'
  scope: rg
  params: {
    vmDcIp: vmDcIp
    vmDcSubnetId: networkDeploy.outputs.spoke1SubnetId
    aaId: automationDeploy.outputs.automationAccountId
    aaJobName: automationDeploy.outputs.automationAccountJobName
  }
}
/*
When deploying the gateway remember to allow usage of remote gateway 
in Spoke1-to-Hub-Peering.

In module networkDeploy it's not possible to set 
because at this time there is no gateway yet:
    "Spoke1-to-Hub-Peering cannot have UseRemoteGateway flag set to true 
     because remote virtual network Hub referenced by the peering does not have any gateways."
*/
module gatewayDeploy 'gateway.bicep' = {
  name: 'gatewayDeploy'
  scope: rg
  params: {
    //gatewayNetwork: foo
    gatewayNetwork: networkDeploy.outputs.hubName
    gatewaySubnetPrefix: gatewaySubnetPrefix
  }
}
