output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.storage.name
}

output "storage_account_primary_access_key" {
  description = "The primary access key for the storage account"
  value       = azurerm_storage_account.storage.primary_access_key
  sensitive   = true
}

output "storage_account_primary_connection_string" {
  description = "The primary connection string for the storage account"
  value       = azurerm_storage_account.storage.primary_connection_string
  sensitive   = true
}

output "storage_account_endpoint" {
  description = "The endpoint for the storage account"
  value = azurerm_storage_account.storage.primary_blob_endpoint
}