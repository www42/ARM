targetScope = 'subscription'

param rgName string

resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: rgName
  location: deployment().location
}

// First: Virtual Network
// ----------------------
module virtualNetwork 'Bicep/VirtualNetwork.bicep' = {
  name: 'networkDeploy'
  scope: rg
  params: {
    vnetName: 'VNet1'
  }
}

// Second: Virtual Machine(s)
// --------------------------
//
//         bicep/WindowsVMpublicIP.bicep  --> Windows Server mit public IP and NSG (for RDP management)
//         bicep/WindowsVM.bicep          --> Windows Server (for Bastion Host)

module virtualMachine1 'Bicep/WindowsVM.bicep' = {
  name: 'vm1Deploy'
  scope: rg
  params: {
     vmName: 'VM1'
     vmSubnetId: virtualNetwork.outputs.serverSubnetId
  }
}

// module virtualMachine2 'Bicep/WindowsVM.bicep' = {
  // name: 'vm2Deploy'
  // scope: rg
  // params: {
    // vmName: 'VM2'
    // vmSubnetId: virtualNetwork.outputs.databaseSubnetId
  // }
// }

// Third: Bastion Host
// -------------------
module bastionHost 'Bicep/BastionHost.bicep' = {
  name: 'bastionDeploy'
  scope: rg
  params: {
    bastionName: 'BastionHost'
    bastionSubnetId: virtualNetwork.outputs.bastionSubnetId
  }
}
