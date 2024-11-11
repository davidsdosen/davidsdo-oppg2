# core variables

variable "rgname" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-tf-davidsdo"
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "westeurope"

}

variable "subscription_id" {
  type        = string
  description = "The subscription ID"
}

# storage

variable "saname" {
  description = "Name of the storage account"
  type        = string
  default     = "sa-tf-davidsdo"
}

variable "storage_tiers" {
  description = "List of storage tiers"
  type        = list(string)
  default     = ["Standard", "Premium"]
}

variable "sa_replicationtype" {
  description = "The replication type for the storage account"
  type        = string
  default     = "LRS"
}

# database

variable "sql_admin_password" {
  description = "The password for the SQL Server admin"
  type        = string
  sensitive   = true
  default     = "admin1234!"
}

variable "sql_admin_username" {
  description = "The username for the SQL Server admin"
  type        = string
  default     = "admin"
}

variable "sql_server_name" {
  description = "The name of the SQL Server"
  type        = string
}

variable "sql_database_name" {
  description = "The name of the SQL Database"
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

variable "database_sku_name" {
  description = "The SKU name for the database"
  type        = string

}

# networking

variable "snname" {
  description = "The name of the subnet"
  type        = string
  default     = "sn-tf-davidsdo"
}

variable "nsgname" {
  description = "The name of the network security group"
  type        = string
  default     = "nsg-tf-davidsdo"
}

variable "vnetname" {
  description = "The name of the virtual network"
  type        = string
  default     = "vnet-tf-davidsdo"
}

variable "nsg_id" {
  type        = string
  description = "The ID of the network security group"

}

# app service

variable "splan_name" {
  description = "The name of the service plan"
  type        = string
}

variable "os_type" {
  description = "The operating system type"
  type        = string
}

variable "lb_name" {
  description = "The name of the load balancer"
  type        = string
}

variable "appservice_sku_name" {
  description = "The SKU name for the app service"
  type        = string
}

