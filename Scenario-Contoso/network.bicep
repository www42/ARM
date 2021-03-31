// Location
param location string = resourceGroup().location

// vnet0
param vnet0Name string                   = 'Hub'
param vnet0AddressSpace string           = '10.0.0.0/16'
param vnet0SubnetName string             = 'Subnet0'
param vnet0SubnetAddressPrefix string    = '10.0.0.0/24'

// vnet1
param vnet1Name string                   = 'Spoke1'
param vnet1AddressSpace string           = '10.1.0.0/16'
param vnet1SubnetName string             = 'Subnet0'
param vnet1SubnetAddressPrefix string    = '10.1.0.0/24'

// vnet2
param vnet2Name string                   = 'Spoke2'
param vnet2AddressSpace string           = '10.2.0.0/16'
param vnet2SubnetName string             = 'Subnet0'
param vnet2SubnetAddressPrefix string    = '10.2.0.0/24'

resource vnet0 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnet0Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet0AddressSpace
      ]
    }
    subnets: [
      {
        name: vnet0SubnetName
        properties: {
          addressPrefix: vnet0SubnetAddressPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
  }
}
resource vnet1 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnet1Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet1AddressSpace
      ]
    }
    subnets: [
      {
        name: vnet1SubnetName
        properties: {
          addressPrefix: vnet1SubnetAddressPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
  }
}
resource vnet2 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnet2Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet2AddressSpace
      ]
    }
    subnets: [
      {
        name: vnet2SubnetName
        properties: {
          addressPrefix: vnet2SubnetAddressPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
  }
}
resource vnet0vnet1peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-08-01' = {
  name: '${vnet0Name}/${vnet0Name}-to-${vnet1Name}-Peering'
  properties: {
    remoteVirtualNetwork: {
      id: vnet1.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: true
    useRemoteGateways: false
  }
}
resource vnet1vnet0peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-08-01' = {
  name: '${vnet1Name}/${vnet1Name}-to-${vnet0Name}-Peering'
  properties: {
    remoteVirtualNetwork: {
      id: vnet0.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: true
    useRemoteGateways: false
  }
}

output hubName        string = vnet0.name
output spoke1Name     string = vnet1.name
output spoke2Name     string = vnet2.name
output hubSubnetId    string = vnet0.properties.subnets[0].id
output spoke1SubnetId string = vnet1.properties.subnets[0].id
output spoke2SubnetId string = vnet2.properties.subnets[0].id
