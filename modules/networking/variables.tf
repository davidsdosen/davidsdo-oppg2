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

variable "address_prefixes" {
  description = "The address prefixes for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "snname" {
  description = "The name of the subnet"
  type        = string
  default     = "sn-tf-davidsdo"
}

variable "dns_servers" {
  description = "List of DNS servers"
  type        = list(string)
  default     = ["10.0.0.4", "10.0.0.5"]
}

variable "source_address_prefix" {
  description = "The source address prefix"
  type        = string
  default     = "*"
}