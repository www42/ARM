resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
    name: 'uniquestorage001' // must be globally unique
    location: 'eastus'
    kind: 'Storage'
    sku: {
        name: 'Standard_LRS'
    }
}
resource VNet1 'Microsoft.Network/virtualnetworks@2017-06-01' = {
    name: 'VNet1'
    location: 'westeurope'
    properties: {
        addressSpace: {
            addressPrefixes: [
                '10.0.0.0/16'
            ]
        }
        subnets: [
            {
                name: 'subnet1'
                properties: {
                    addressPrefix: '10.0.0.0/24'
                }
            }
        ]
    }
}