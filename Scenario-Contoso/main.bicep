targetScope = 'subscription'

param rgName string = 'Contoso-RG'

resource rg 'Microsoft.Resources/resourceGroups@2020-10-01' = {
  name: rgName
  location: deployment().location
}
module networkDeploy 'network.bicep' = {
  name: 'networkDeploy'
  scope: rg
  params: {
    // Hub
    vnet0Name:                'Hub'
    vnet0AddressSpace:        '10.0.0.0/16'
    vnet0SubnetAddressPrefix: '10.0.0.0/24'
    vnet0BastionSubnetPrefix: '10.0.255.0/27'
    deployVnet0Bastion:       false
    // Spoke1
    vnet1Name:                'Spoke1'
    vnet1AddressSpace:        '10.1.0.0/16'
    vnet1SubnetAddressPrefix: '10.1.0.0/24'
    vnet1BastionSubnetPrefix: '10.1.255.0/27'
    deployVnet1Bastion:       true
    // Spoke 2
    vnet2Name:                'Spoke2'
    vnet2AddressSpace:        '10.2.0.0/16'
    vnet2SubnetAddressPrefix: '10.2.0.0/24'
    vnet2BastionSubnetPrefix: '10.2.255.0/27'
    deployVnet2Bastion:       true
  }
}
// Remember: Automation account jobs are not idempotent!
module automationDeploy 'automation.bicep' = {
  name: 'automationDeploy'
  scope: rg
  params: {
    aaName: 'Contoso-Automation'
    deployAaJob: false
  }
}
module dc1Deploy 'vm.bicep' = {
  name: 'dc1Deploy'
  scope: rg
  params: {
    vmName:           'DC1'
    vmIp:             '10.1.0.200'
    vmSubnetId:       networkDeploy.outputs.spoke1SubnetId
    aaId:             automationDeploy.outputs.automationAccountId
    aaConfiguration: 'ADDomain_NewForest.localhost'
  }
}
module vm2Deploy 'vm.bicep' = {
  name: 'vm2Deploy'
  scope: rg
  params: {
    vmName:          'VM2'
    vmIp:            '10.2.0.200'
    vmSubnetId:      networkDeploy.outputs.spoke2SubnetId
    aaId:            automationDeploy.outputs.automationAccountId
    aaConfiguration: ''
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
/*
module gatewayDeploy 'gateway.bicep' = {
  name: 'gatewayDeploy'
  scope: rg
  params: {
    //gatewayNetwork: foo
    gatewayNetwork: networkDeploy.outputs.hubName
    gatewaySubnetPrefix: '10.0.255.32/27'
  }
}
*/
