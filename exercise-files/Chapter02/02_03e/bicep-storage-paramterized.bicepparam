using './bicep-storage.bicep'

@description('Name of the storage account')
@minlength(4)
@maxlength(20)
param storageName = 'mystoragepa1997'

@description('Azure region where the resources will be deployed')
@allowed(['eastus2','eastus','westus2'])
param azregion = 'eastus2'

@description('Storage account redundancy option')
@allowed(['Standard_LRS','standard_GRS'])
param SKUname

@description('The type of storage account that will be used inside the region')
param kind  = 'StorageV2'

@description('Name of the storage account')
@allowed(['Dev','Prod','Staging','test'])
param environment
