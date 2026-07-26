// main.bicep

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

var stgAccountName = '${sname}${environment}'

param aspName string // 'mybicep-asp01'
param webAppName string // 'mybicep-web-app01'

module storagemodulecall 'bicepstorage.bicep' = {
  name: 'storagedeployment'
  params: {
    sname: stgAccountName
    slocation:azureRegion
    skind: skuName
    ssku: ssku
  }
}

module appserviceresource 'appservice.bicep'= {
  name: 'appservicedeplyment'
  params:{
    aspName:aspName
    webAppName:webAppName
    azureRegion:azureRegion
  }
}

output storageId string = storagemodulecall.outputs.storageId
output blobEndPoint string = storagemodulecall.outputs.blobEndPoint
output webAppHostName string = appserviceresource.outputs.webAppHostName
