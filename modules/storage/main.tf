# Fundamental building block to store data in Azure
resource "azurerm_storage_account" "storage" {
  name                     = var.saname
  resource_group_name      = var.rgname
  location                 = var.location
  account_tier             = var.storage_tiers[0]
  account_replication_type = var.sa_replicationtype
  min_tls_version          = var.min_tls_version
}

# Storage container within the storage account used to organize and manage blobs (binary large objects) aka. collection of binary data stored as a single entity
resource "azurerm_storage_container" "container" {
  name                  = var.contname
  storage_account_id  = azurerm_storage_account.storage.id
  container_access_type = var.contaccesstype
}