// container-registry


param acrname string = 'resorceGroup'
param acregion string = resourceGroup().location
param acrsku string = 'basic'
param enableadministrator bool = true

targetScope = 'resourceGroup'
resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: 'demoACR'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

//shows the admin login URL
output acrloginserver string = containerRegistry.properties.loginServer

