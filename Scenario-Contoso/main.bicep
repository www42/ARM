targetScope = 'subscription'

param rgName string            = 'Contoso-RG'
param deployHubBastion bool    = false
param deploySpoke1Bastion bool = true
param deploySpoke2Bastion bool = false
param deployAaCompileJob bool  = true
param gwExists  bool           = false

/*
// =============================
var deployHubBastion    = false
var deploySpoke1Bastion = true
var deploySpoke2Bastion = true
var deployAaCompileJob  = true
var gwExists            = false
// =============================
*/

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
    deployVnet0Bastion:       deployHubBastion
    // Spoke1
    vnet1Name:                'Spoke1'
    vnet1AddressSpace:        '10.1.0.0/16'
    vnet1SubnetAddressPrefix: '10.1.0.0/24'
    vnet1BastionSubnetPrefix: '10.1.255.0/27'
    deployVnet1Bastion:       deploySpoke1Bastion
    // Spoke 2
    vnet2Name:                'Spoke2'
    vnet2AddressSpace:        '10.2.0.0/16'
    vnet2SubnetAddressPrefix: '10.2.0.0/24'
    vnet2BastionSubnetPrefix: '10.2.255.0/27'
    deployVnet2Bastion:       deploySpoke2Bastion
    // Peering
    gatewayExists:            gwExists
  }
}
// Remember: Automation account jobs are not idempotent!
module automationDeploy 'automation.bicep' = {
  name: 'automationDeploy'
  scope: rg
  params: {
    aaName: 'Contoso-Automation'
    deployAaJob: deployAaCompileJob
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
module vm0Deploy 'vm.bicep' = {
  name: 'vm1Deploy'
  scope: rg
  params: {
    vmName:          'VM0'
    vmIp:            '10.0.0.200'
    vmSubnetId:      networkDeploy.outputs.hubSubnetId
    aaId:            automationDeploy.outputs.automationAccountId
    aaConfiguration: ''
  }
}
/*
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
*/
// Remember: "Spoke1-to-Hub-Peering cannot have UseRemoteGateway flag set to true because remote virtual network Hub referenced by the peering does not have any gateways."
module gatewayDeploy 'gateway.bicep' = {
  name: 'gatewayDeploy'
  scope: rg
  params: {
    gatewayName:     'Contoso-Gateway'
    gatewaySubnetId: networkDeploy.outputs.hubGatewaySubnetId
  }
}
