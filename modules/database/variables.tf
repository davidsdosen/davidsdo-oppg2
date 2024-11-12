variable "rgname" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-tf-davidsdo"
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
}

variable "sql_admin_password" {
  description = "The password for the SQL Server admin"
  type        = string
  sensitive   = true
  default = "admin1234!"
}

variable "sql_admin_username" {
  description = "The username for the SQL Server admin"
  type        = string
  default = "admin"
}

variable "sql_server_name" {
  description = "The name of the SQL Server"
  type        = string
}

variable "sql_database_name" {
  description = "The name of the SQL Database"
  type        = string
}

variable database_sku_name {
  description = "The SKU name"
  type        = string
}

variable "enclave_type" {
  description = "The enclave type"
  type        = string
  default     = "VBS"
}

variable "sql_database_size_gb" {
  description = "The size of the SQL Database in GB"
  type        = number
  default     = 2
}

variable "prevent_destroy" {
  description = "Prevent accidental deletion of the database"
  type        = bool
  default     = true
}

variable "audit_storage_endpoint" {
  description = "The endpoint URL of the storage account for SQL audit logs"
  type        = string
  default     = "https://mystorageaccount.blob.core.windows.net/"
}

variable "audit_storage_access_key" {
  description = "The access key for the storage account used in SQL audit logs"
  type        = string
  default     = "fakeaccesskeyforlocaldevonly"
  sensitive   = true
}
