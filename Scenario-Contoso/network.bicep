// Location
param location string = resourceGroup().location

// Hub network
param vnetHubName string = 'Hub'
param vnetHubAddressSpace string = '172.16.0.0/16'
param vnetHubSubnetName string = 'Subnet0'
param vnetHubSubnetAddressPrefix string = '172.16.0.0/24'

// Spoke1 network
param vnetSpoke1Name string = 'Spoke1'
param vnetSpoke1AddressSpace string = '172.17.0.0/16'
param vnetSpoke1SubnetName string = 'Subnet0'
param vnetSpoke1SubnetAddressPrefix string = '172.17.0.0/24'

// Spoke2 network
param vnetSpoke2Name string = 'Spoke2'
param vnetSpoke2AddressSpace string = '172.18.0.0/16'
param vnetSpoke2SubnetName string = 'Subnet0'
param vnetSpoke2SubnetAddressPrefix string = '172.18.0.0/24'

resource hub 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnetHubName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetHubAddressSpace
      ]
    }
    subnets: [
      {
        name: vnetHubSubnetName
        properties: {
          addressPrefix: vnetHubSubnetAddressPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
  }
}
resource spoke1 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnetSpoke1Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetSpoke1AddressSpace
      ]
    }
    subnets: [
      {
        name: vnetSpoke1SubnetName
        properties: {
          addressPrefix: vnetSpoke1SubnetAddressPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
  }
}
resource spoke2 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnetSpoke2Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetSpoke2AddressSpace
      ]
    }
    subnets: [
      {
        name: vnetSpoke2SubnetName
        properties: {
          addressPrefix: vnetSpoke2SubnetAddressPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
  }
}
resource hubspoke1peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = {
  name: '${vnetHubName}/${vnetHubName}-to-${vnetSpoke1Name}-Peering'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: true
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: spoke1.id
    }
  }
}



output hubName string = hub.name
output spoke1Name string = spoke1.name
output spoke2Name string = spoke2.name
output hubSubnetId string = hub.properties.subnets[0].id
output spoke1SubnetId string = spoke1.properties.subnets[0].id
output spoke2SubnetId string = spoke2.properties.subnets[0].id
