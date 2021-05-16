targetScope = 'subscription'

param rgName string 

resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: rgName
  location: deployment().location
}

// First: Automation Account
// Remember: Automation account jobs are not idempotent! This means 
//    deployAaJob: true         only for the first time, in later deployment set to 'false'
//
module automationDeploy 'automation.bicep' = {
  name: 'automationDeploy'
  scope: rg
  params: {
    aaName: 'Contoso-Automation'
    deployAaJob: true
  }
}

// Next: Hub and Spoke 
module hubAndSpokeDeploy 'Hub-and-Spoke.bicep' = {
  name: 'hubAndSpokeDeploy'
  scope: rg
  params: {
    aaId:             automationDeploy.outputs.automationAccountId
    aaConfiguration: 'ADDomain_NewForest.localhost'    
  }
}
