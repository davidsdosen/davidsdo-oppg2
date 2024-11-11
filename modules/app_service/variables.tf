variable "rgname" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
}

variable "splan_name" {
  description = "The name of the service plan"
  type        = string
}

variable "os_type" {
  description = "The operating system type"
  type        = string
}

variable "appservice_sku_name" {
  description = "The SKU name"
  type        = string
}

variable "lb_name" {
  description = "The name of the load balancer"
  type        = string
}
