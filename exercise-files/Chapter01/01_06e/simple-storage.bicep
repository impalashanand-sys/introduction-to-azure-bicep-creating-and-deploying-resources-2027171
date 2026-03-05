resource firstbicepstg123 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'firstbicepstg123'
  location: 'eastus2'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  tags: {
    Environment: 'Demo'
    Project: 'Intro to Azure Bicep'
  }
}
