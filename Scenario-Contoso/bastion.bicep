// Location
param location string = resourceGroup().location

// Virtual network
param vnetName string
param bastionSubnetPrefix string

var bastionHostName = '${vnetName}-Bastion'

resource bastionHost 'Microsoft.Network/bastionHosts@2020-08-01' = {
  name: bastionHostName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipConfig1'
        properties: {
          publicIPAddress: {
            id: bastionPip.id
          }
          subnet: {
            id: bastionSubnet.id
          }
        }
      }
    ]
  }
}
resource bastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-08-01' = {
  name: '${vnetName}/AzureBastionSubnet'
  properties: {
    addressPrefix: bastionSubnetPrefix
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}
resource bastionPip 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: '${bastionHostName}-Pip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}
// output bastionSubnetId string = bastionSubnet.id
