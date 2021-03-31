// Location
param location string = resourceGroup().location

// vnet0
param vnet0Name string                   = 'Hub'
param vnet0AddressSpace string           = '10.0.0.0/16'
param vnet0SubnetName string             = 'Subnet0'
param vnet0SubnetAddressPrefix string    = '10.0.0.0/24'
param vnet0BastionSubnetName string      = 'AzureBastionSubnet' // Do not change!
param vnet0BastionSubnetPrefix string    = '10.0.255.0/27'
param deployVnet0Bastion bool            = false

// vnet1
param vnet1Name string                   = 'Spoke1'
param vnet1AddressSpace string           = '10.1.0.0/16'
param vnet1SubnetName string             = 'Subnet0'
param vnet1SubnetAddressPrefix string    = '10.1.0.0/24'
param vnet1BastionSubnetName string      = 'AzureBastionSubnet' // Do not change!
param vnet1BastionSubnetPrefix string    = '10.1.255.0/27'
param deployVnet1Bastion bool            = false

// vnet2
param vnet2Name string                   = 'Spoke2'
param vnet2AddressSpace string           = '10.2.0.0/16'
param vnet2SubnetName string             = 'Subnet0'
param vnet2SubnetAddressPrefix string    = '10.2.0.0/24'
param vnet2BastionSubnetName string      = 'AzureBastionSubnet' // Do not change!
param vnet2BastionSubnetPrefix string    = '10.2.255.0/27'
param deployVnet2Bastion bool            = false

// Hub, Spoke1, Spoke2
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
        }
      }
      {
        name: vnet0BastionSubnetName
        properties: {
          addressPrefix: vnet0BastionSubnetPrefix
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
        }
      }
      {
        name: vnet1BastionSubnetName
        properties: {
          addressPrefix: vnet1BastionSubnetPrefix
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
        }
      }
      {
        name: vnet2BastionSubnetName
        properties: {
          addressPrefix: vnet2BastionSubnetPrefix
        }
      }
    ]
  }
}
// Peerings
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
// Bastion Hosts
resource bastionVnet0 'Microsoft.Network/bastionHosts@2020-08-01' = if (deployVnet0Bastion) {
  name: '${vnet0Name}-Bastion'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipConfig1'
        properties: {
          publicIPAddress: {
            id: bastionVnet0Pip.id
          }
          subnet: {
            id: vnet0.properties.subnets[1].id
          }
        }
      }
    ]
  }
}
resource bastionVnet1 'Microsoft.Network/bastionHosts@2020-08-01' = if (deployVnet1Bastion) {
  name: '${vnet1Name}-Bastion'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipConfig1'
        properties: {
          publicIPAddress: {
            id: bastionVnet1Pip.id
          }
          subnet: {
            id: vnet1.properties.subnets[1].id
          }
        }
      }
    ]
  }
}
resource bastionVnet2 'Microsoft.Network/bastionHosts@2020-08-01' = if (deployVnet2Bastion) {
  name: '${vnet2Name}-Bastion'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipConfig1'
        properties: {
          publicIPAddress: {
            id: bastionVnet2Pip.id
          }
          subnet: {
            id: vnet2.properties.subnets[1].id
          }
        }
      }
    ]
  }
}
resource bastionVnet0Pip 'Microsoft.Network/publicIPAddresses@2020-08-01' = if (deployVnet0Bastion) {
  name: '${vnet0Name}-Bastion-Pip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}
resource bastionVnet1Pip 'Microsoft.Network/publicIPAddresses@2020-08-01' = if (deployVnet1Bastion) {
  name: '${vnet1Name}-Bastion-Pip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}
resource bastionVnet2Pip 'Microsoft.Network/publicIPAddresses@2020-08-01' = if (deployVnet2Bastion) {
  name: '${vnet2Name}-Bastion-Pip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

// output hubName        string = vnet0.name
// output spoke1Name     string = vnet1.name
// output spoke2Name     string = vnet2.name
output hubSubnetId    string = vnet0.properties.subnets[0].id
output spoke1SubnetId string = vnet1.properties.subnets[0].id
output spoke2SubnetId string = vnet2.properties.subnets[0].id
