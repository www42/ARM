param location string = resourceGroup().location
param gatewayName string = 'Contoso-Gateway'
param gatewaySubnetPrefix string
param gatewayNetwork string

resource gateway 'Microsoft.Network/virtualNetworkGateways@2020-08-01' = {
  name: gatewayName
  location: location
  properties: {
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    vpnGatewayGeneration: 'Generation1'
    sku: {
      name: 'VpnGw1'
      tier:'VpnGw1'
    }
    ipConfigurations: [
      {
        name: 'ipConfig1'
        properties: {
          publicIPAddress: {
            id: gatewayPip.id
          }
          subnet: {
            id: gatewaySubnet.id
          }
        }
      }
    ]
  }
}
resource gatewaySubnet 'Microsoft.Network/virtualNetworks/subnets@2020-08-01' = {
  name: '${gatewayNetwork}/GatewaySubnet'
  properties: {
    addressPrefix: gatewaySubnetPrefix
  }
}
resource gatewayPip 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: '${gatewayName}-Pip'
  location: location
  sku: {
    name: 'Basic'    
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}
