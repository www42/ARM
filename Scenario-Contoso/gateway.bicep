// Location
param location string = resourceGroup().location

// Gateway
param gatewayName string = 'Contoso-Gateway'
param gatewaySubnetId string

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
            id: gatewaySubnetId
          }
        }
      }
    ]
    vpnClientConfiguration: {
      vpnClientAddressPool: {
        addressPrefixes: [
          '192.168.0.0/24'
        ]
      }
      vpnClientProtocols: [
        'SSTP'
        'IkeV2'
        'OpenVPN'
      ]
      vpnClientRootCertificates: [
        {
          name: 'ContosoRoot'
          properties: {
            publicCertData: 'MIIC/TCCAeWgAwIBAgIQLkXhAXtvLpNLhIyjznYWvDANBgkqhkiG9w0BAQsFADAhMR8wHQYDVQQDDBZDb250b3NvUm9vdENlcnRpZmljYXRlMB4XDTIxMDQwMzE3MDYzM1oXDTIyMDQwMzE3MjYzM1owITEfMB0GA1UEAwwWQ29udG9zb1Jvb3RDZXJ0aWZpY2F0ZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAPuJ3KWFvVYrewuSQxVelRbORNtNkSqMrHUj9N73XzkxEBODjfb3IJd/bGNNn70Z9YUDElFbKEVfHs2icZfCqiLNT4ejnN49La/Zp17qYDumFtiUErc5PVJA8Op1swURcFeHeuHsZdq1ADi8+M51o4nWFh80mJay2g/GUwE0UxOyDNerVLIXkZPQ89UngKb3cZN7TtCQXW6CJGMFLY07KbNiwpQuFg9DbxVR0bOoMi2MgnYalweBt/JHCMwLFfzZ4DwuNVYwGWFtnaBjTv5XgBQrxVvXzCxHUXhznSLClqJ8PTTTM6ZgPC4l1BuIVWZfyI5S3WdvyT8dhVmpVTaQc/kCAwEAAaMxMC8wDgYDVR0PAQH/BAQDAgIEMB0GA1UdDgQWBBRfYo+dRHQ5rVdtOyo27ez1Odc5ijANBgkqhkiG9w0BAQsFAAOCAQEArg3ElQzE8537qJUGQIvYU1JwI6tpeyBta7bmV3qg8G0ha02rn7gPJHpLhwgVhQU3kuFm0+Lfyza8Jk3PMSCueD80MKocxnEd9m147lCDBbTmXHAWe5OcaW8fzemf574jxl1XVS2/4FBvU0/Al6XwneRcRblr0mvhhiUbWBu9dhWSIkqnvOqu6zPbJIIwaXcV7qZ0e1GthI/QL4jSu02XtogJ01ESTWvJPFYntoWsuk5R/2z6gAImQvb9PAhm7nAqz8MkXmcfQFmo7VYiiL1+tzAVryAqNkQFKrJnR368xGIFzKLF/YNqOYPn0xYNfL9rIoi+yMT7fgq61U/4Cj/AKA=='
          }
        }
      ]
    }
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
