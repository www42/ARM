// Virtual Machine
param location string = resourceGroup().location

param vmName          string = 'VM'
param vmSize          string = 'Standard_DS2_v2'
param vmAdminUserName string = 'Student'
param vmAdminPassword string = 'Pa55w.rd1234'
param vmSubnetId      string

resource vm 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      imageReference:{
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        name: '${vmName}-Disk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    osProfile: {
      computerName: '${vmName}'
      adminUsername: vmAdminUserName
      adminPassword: vmAdminPassword
    }
    networkProfile:{
      networkInterfaces: [
        {
          id: vmNic.id
        }
      ]
    }
  }
}
resource vmNic 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: '${vmName}-Nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipConfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: vmSubnetId
          }
          publicIPAddress: {
            id: vmPip.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: vmNsg.id
    }
  }
}
resource vmPip 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: '${vmName}-Pip'
  location: location
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Dynamic'
  }
}
resource vmNsg 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: '${vmName}-NSG'
  location: location
  properties: {
    securityRules: [
      {
        name: 'Allow_RemoteDesktop'
        properties: {
          description: 'Allow Remote Desktop Protocol port TCP/3389'
          direction: 'Inbound'
          priority: 100
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '3389'
          protocol: 'Tcp'
          access: 'Allow'
        }
      }
    ]
  }
}
