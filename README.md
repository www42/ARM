# Azure ARM Templates
## How to author ARM templates

[Tutorial: Create and deploy your first ARM template](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-create-first-template) (Microsoft Docs)

[Tutorial: Use Azure Quickstart templates](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-quickstart-template) (Microsoft Docs)

[Neil Peterson explains the ARM Tools for VS Code](https://channel9.msdn.com/Shows/IT-Ops-Talk/Azure-Resource-Manager-Tools-for-VS-Code) (Channel 9)


| Template                                     | Purpose      |
|----------------------------------------------|--------------|
| [empty.json](empty.json)                     | Delete all resources in a resource group (complete mode deployment) |
| [vnet.json](vnet.json)                       | Virtual Network |
| [subnet.json](subnet.json)                   | Add Subnet to existing Virtual Network |
| [vnet_bastion.json](vnet_bastion.json)       | Virtual Network with Bastian Host |
| [vnet_bastion_vm.json](vnet_bastion_vm.json) | Virtual Network with Bastion Host and single VM |
| [ps-61.json](ps-61.json)                     | PS-61 Scenario: Virtual Network with Bastion Host and three VMs |