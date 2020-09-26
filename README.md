# My Azure ARM Templates

### What are ARM templates?
* [ARM templates are ...](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/overview) (Microsoft Docs)

* [Tutorial: Create and deploy your first ARM template](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-create-first-template) (Microsoft Docs)

### How to author ARM templates?

* [Tutorial: Use Azure Quickstart templates](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-quickstart-template) (Microsoft Docs)

* [Neil Peterson explains the ARM Tools for VS Code](https://channel9.msdn.com/Shows/IT-Ops-Talk/Azure-Resource-Manager-Tools-for-VS-Code) (Channel 9)


### My templates:

| Template                                                   | Purpose      
|------------------------------------------------------------|--------------
| [Empty.json](templates/Empty.json)                         | Delete all resources in a resource group (complete mode deployment). 
| [VirtualNetwork.json](templates/VirtualNetwork.json)       | Create Virtual Network with one subnet included
| [Subnet.json](templates/Subnet.json)                       | Add Subnet to existing Virtual Network. 
| [Bastion.json](templates/Bastion.json)                     | Add Bastian Host service to a Virtual Network. 
| [Automation.json](templates/Automation.json)               | Create Automation Account, upload DSC configurations, and compile them to MOF
| [Vm.json](templates/Vm.json)                               | Create VM, no public IP
| [ps-61.json](templates/ps-61.json)                         | PS-61 Scenario: Virtual Network with Bastion Host and three VMs. 

[![](img/empty.png)](#)

Have fun with Microsoft Learn!

[![](img/mascot-doc.png)](https://aka.ms/AzureAdminInfographic)
[Learning path for Azure Administrator](https://aka.ms/AzureAdminInfographic)