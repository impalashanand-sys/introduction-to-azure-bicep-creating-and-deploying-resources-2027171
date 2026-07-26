// bicep-storage.bicep

@description('Name of the storage account')
@minLength(4)
@maxLength(30)
param storageName string

@description('Azure region where the resources will be deployed')
@allowed(['eastus2','eastus','westus2'])
param azregion string = 'eastus2'

@description('Storage account redundancy option')
@allowed(['Standard_LRS','standard_GRS'])
param SKUname string

@description('The type of storage account that will be used inside the region')
param kind  string = 'StorageV2'

@description('Name of the storage account')
@allowed(['dev','prod','staging','test'])
param environment string

var sku = environment == 'dev' ? 'Standard_GRS' : 'Standard_LRS'

resource bicepStorage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: '${storageName}${uniqueString(resourceGroup().id)}${environment}'
  location: azregion
  kind: kind
  sku: {
    name: sku
  }
}

output storageName string = bicepStorage.id
