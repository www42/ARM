# My Azure ARM Templates

### What are ARM templates?
* [ARM templates are ...](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/overview) (Microsoft Docs)

* [Tutorial: Create and deploy your first ARM template](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-create-first-template) (Microsoft Docs)

### How to author ARM templates?

* [Tutorial: Use Azure Quickstart templates](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-quickstart-template) (Microsoft Docs)

* [Neil Peterson explains the ARM Tools for VS Code](https://channel9.msdn.com/Shows/IT-Ops-Talk/Azure-Resource-Manager-Tools-for-VS-Code) (Channel 9)


### My templates:

| Template                                               | Purpose      |
|--------------------------------------------------------|--------------|
| [empty.json](templates/empty.json)                     | Delete all resources in a resource group (complete mode deployment). |
| [vnet.json](templates/vnet.json)                       | Create Virtual Network |
| [subnet.json](templates/subnet.json)                   | Add Subnet to existing Virtual Network. |
| [vnet_bastion.json](templates/vnet_bastion.json)       | Create Virtual Network with Bastian Host. |
| [vnet_bastion_vm.json](templates/vnet_bastion_vm.json) | Create Virtual Network with Bastion Host and single VM. |
| [ps-61.json](templates/ps-61.json)                     | PS-61 Scenario: Virtual Network with Bastion Host and three VMs. |

[![](img/empty.png)](#)

Have fun with Microsoft Learn!

[![](img/mascot-doc.png)](https://aka.ms/AzureAdminInfographic)
[Learning path for Azure Administrator](https://aka.ms/AzureAdminInfographic)