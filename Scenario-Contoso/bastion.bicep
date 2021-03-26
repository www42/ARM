param location string = resourceGroup().location
param vnetName string
param bastionSubnetPrefix string

var bastionHostName = '${vnetName}-Bastion'


resource bastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-08-01' = {
  name: '${vnetName}/AzureBastionSubnet'
  properties: {
    addressPrefix: bastionSubnetPrefix
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}
resource bastionHost 'Microsoft.Network/bastionHosts@2020-08-01' = {
  name: bastionHostName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipConfig1'
        properties: {
          publicIPAddress: {
            id: bastionHostPip.id
          }
          subnet: {
            id: bastionSubnet.id
          }
        }
      }
    ]
  }
}
resource bastionHostPip 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: '${bastionHostName}-Pip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}
output bastionSubnetId string = bastionSubnet.id
