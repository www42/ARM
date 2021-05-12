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
        }
      }
    ]
  }
}
