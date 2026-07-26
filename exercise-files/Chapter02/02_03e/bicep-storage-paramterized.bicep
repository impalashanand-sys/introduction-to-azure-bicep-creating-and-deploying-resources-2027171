// bicep-storage-parametrized.bicep

param storageName string = 'mystoragepa1997'
param azureregion string = 'eastus2'
param SKUname string = 'Standard_LRS'
param kind string = 'StorageV2'

resource bicepStorage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageName
  location: azureregion
  kind: kind
  sku: {
    name: SKUname
  }
}
