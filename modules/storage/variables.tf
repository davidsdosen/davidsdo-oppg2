variable "saname" {
  description = "Name of the storage account"
  type        = string
  default     = "sa-tf-davidsdo"
}

variable "rgname" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-tf-davidsdo"
}

variable "contname" {
  description = "Name of the storage container"
  type        = string
  default     = "scont-tf-davidsdo"
}

variable "contaccesstype" {
  description = "The access type for the storage container"
  type        = string
  default     = "private"
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "westeurope"
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