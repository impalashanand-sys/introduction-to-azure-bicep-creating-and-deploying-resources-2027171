// simple-storage.bicep

resource bicepStorage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'testbiceplokipa1997'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
