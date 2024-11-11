locals{
# creates a workspace suffix if the workspace is not default
workspace_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"

# checks if the workspace is default and creates a resource group name amd storage account name with the workspace suffix if the workspace is not default
rgname = terraform.workspace == "default" ? "${var.rgname}" : "${var.rgname}-${local.workspace_suffix}"
saname = terraform.workspace == "default" ? "${var.saname}" : "${var.saname}-${local.workspace_suffix}"

}

# specifies the provider and version. This allows the terraform plugin to interact with Microsoft Azure
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.9.0"
    }
  }
}


# various configuration settings for the Azure provider
provider "azurerm" {
  # configuration options
  features {}
  subscription_id = var.subscription_id
}

# creates a resource group in Azure
resource "azurerm_resource_group" "rg" {
  name     = local.rgname
  location = var.location
}

# generates a random string of 8 characters without special characters and uppercase letters
resource "random_string" "random_string" {
length = 8
special = false
upper = false
}


# reusable modules for storage, storage, networking, mssql database and app. Each module is defined in its own directory


module "storage" {
  source             = "../modules/storage"
  saname             = "${lower(local.saname)}-${random_string.random_string.result}"
  rgname             = azurerm_resource_group.rg.name
  location           = azurerm_resource_group.rg.location
  storage_tiers      = var.storage_tiers
  sa_replicationtype = var.sa_replicationtype
}

module "networking" {
  source   = "../modules/networking"
  rgname   = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  vnetname = var.vnetname
  snname   = var.snname
  nsgname  = var.nsgname
  #subnet_id = var.subnet_id
}

module "database" {
  source               = "../modules/database"
  rgname               = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  sql_admin_username   = var.sql_admin_username
  sql_admin_password   = var.sql_admin_password
  sql_server_name      = var.sql_server_name
  sql_database_name    = var.sql_database_name
  database_sku_name    = var.database_sku_name
  enclave_type         = var.enclave_type
  sql_database_size_gb = var.sql_database_size_gb
}

module "app_service" {
  source              = "../modules/app_service"
  rgname              = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  splan_name          = var.splan_name
  os_type             = var.os_type
  lb_name             = var.lb_name
  appservice_sku_name = var.appservice_sku_name

}