// main.bicep


targetScope = 'subscription'

@minLength(3)
@maxLength(20)
param sname string

param ssku string = 'StorageV2'

@description('Azure regional location where resource will be deployed')
param azureRegion string

@allowed(['dev', 'test', 'prod'])
param environment string = 'dev'

@description('Storage SKU defined based on environment type')
var skuName = environment == 'prod' ? 'Standard_GRS' : 'Standard_LRS'

var stgAccountName = '${sname}pa${environment}'

param aspName string // 'mybicep-asp01'
param webAppName string // 'mybicep-web-app01'
param crname string
param crskuname string
param adminuserpermission bool = false

resource storagerg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'web-dev-deployment-resource-group'
  location: azureRegion
  tags: {
    Environment: 'test'
    Project: 'Web-dev-storage resource group'
  }
}


module storagemodulecall 'bicepstorage.bicep' = {
  scope : resourceGroup(storagerg.name)
  name: 'storagedeployment'
  params: {
    sname: stgAccountName
    slocation:azureRegion
    skind: ssku
    ssku: skuName
  }
}

resource appservicerg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'web-dev-app-deployment-resource-group'
  location: azureRegion
  tags: {
    Environment: 'test'
    Project: 'Web-dev-appservice resource group'
  }
}
module appserviceresource 'appservice.bicep'= {
  scope : resourceGroup(appservicerg.name)
  name: 'appservicedeplyment'
  params:{
    aspName:aspName
    webAppName:webAppName
    azureRegion:azureRegion
  }
}

module container 'containerregistry.bicep'= {
  scope : resourceGroup(storagerg.name)
 name: 'Containerdeployment'
  params:{
    crname:crname
    crskuname:crskuname
    azureregion:azureRegion
    adminuserpermission:adminuserpermission
  }
}

output storageId string = storagemodulecall.outputs.storageId
output blobEndPoint string = storagemodulecall.outputs.blobEndPoint
output webAppHostName string = appserviceresource.outputs.webAppHostName
output ContainerServerLoginCreds string = container.outputs.containerregistry
