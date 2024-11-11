output "storage_account_primary_connection_string" {
  description = "Connection string of the Storage Account"
  value       = module.storage.storage_account_primary_connection_string
  sensitive   = true
}

output "name" {
  description = "Name of the Storage Account"
  value       = module.storage.storage_account_name

}

