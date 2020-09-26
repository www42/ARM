# DSC in Azure

## Azure Automation State Configuration overview

* Public endpoint to pull DSC configurations (Your pull server in Azure.)
* Nodes from Azure / on prem / other clouds / Windows / Linux
* Central artefact management
* Central complience reporting

[Azure Automation State Configuration overview | Microsoft Docs](https://docs.microsoft.com/en-us/azure/automation/automation-dsc-overview)

[Az.Automation PowerShell Module Reference](https://docs.microsoft.com/en-us/powershell/module/az.automation/?view=azps-4.7.0&viewFallbackFrom=azps-3.7.0#automation)

## Workflow

* Write DSC configurations
* Upload configurations to Azure Automation Account
* Import DSC modules into Azure Automation Account
* Compile configurations to MOF artefacts
* Onboard nodes
* Be happy