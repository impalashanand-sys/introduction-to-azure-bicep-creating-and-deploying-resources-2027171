
param crname string
param azureregion string
param crskuname string
param adminuserpermission bool = false

targetScope = 'resourceGroup'
resource containerRegistry 'Microsoft.ContainerRegistry/registries@2021-06-01-preview' = {
  name: crname
  location: azureregion
  sku: {
    name: crskuname
  }
  properties: {
    adminUserEnabled: adminuserpermission
  }
}

output containerregistry string = containerRegistry.properties.loginServer

