// Experimental storage account resources
param sname string
param slocation string
param ssku string
param skind string

@description('Experimental storage account resources')
resource bicepStorage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: sname
  location: slocation
  kind: skind
  sku: {
    name: ssku
  }
}

output storageId string = bicepStorage.id
output blobEndPoint string = bicepStorage.properties.primaryEndpoints.blob

