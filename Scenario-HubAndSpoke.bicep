targetScope = 'subscription'

param rgName string 

resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: rgName
  location: deployment().location
}

// First: Automation Account
<<<<<<< HEAD:Hub-and-Spoke/Main.bicep
// Remember: Automation account jobs are not idempotent! This means 
//    deployAaJob: true         only for the first time, in later deployment set to 'false'
//
module automationDeploy 'automation.bicep' = {
  name: 'automationDeploy'
  scope: rg
  params: {
    aaName: 'Contoso-Automation'
=======
module automationDeploy 'Bicep/AutomationAccount.bicep' = {
  name: 'automationDeploy'
  scope: rg
  params: {
    aaName: 'Adatum-Automation'
    
    // Attention! Automation account jobs are not idempotent! This means 
    //    deployAaJob: true     only for the first time, in later deployment set to 'false'
>>>>>>> d9dbb9d4fcb599048cb81a3f3d3f8b327fcc71da:Scenario-HubAndSpoke.bicep
    deployAaJob: true
  }
}

// Next: Hub and Spoke 
<<<<<<< HEAD:Hub-and-Spoke/Main.bicep
module hubAndSpokeDeploy 'Hub-and-Spoke.bicep' = {
=======
module hubAndSpokeDeploy 'Bicep/HubAndSpoke.bicep' = {
>>>>>>> d9dbb9d4fcb599048cb81a3f3d3f8b327fcc71da:Scenario-HubAndSpoke.bicep
  name: 'hubAndSpokeDeploy'
  scope: rg
  params: {
    aaId:             automationDeploy.outputs.automationAccountId
    aaConfiguration: 'ADDomain_NewForest.localhost'    
  }
}
