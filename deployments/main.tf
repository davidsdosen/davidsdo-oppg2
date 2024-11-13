locals {
  # creates a workspace suffix if the workspace is not default
  workspace_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"

  # checks if the workspace is default and creates a resource group name amd storage account name with the workspace suffix if the workspace is not default
  rgname = terraform.workspace == "default" ? "${var.rgname}" : "${var.rgname}-${local.workspace_suffix}"
  saname = terraform.workspace == "default" ? "${var.saname}" : "${var.saname}${local.workspace_suffix}"
}

# specifies the backend for storing the tfstate, provider and its version. This allows the terraform plugin to interact with Microsoft Azure APIs
terraform {
  backend "azurerm" {
    resource_group_name  = "tf-backend-rg-davidsdo"
    storage_account_name = "tfsabackenddavidsdo"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.9.0"
    }
  }
}

# various configuration settings for the Azure provider including the subscription_id to use for the deployment
provider "azurerm" {
  # configuration options
  features {}
  subscription_id = var.subscription_id
}

# creates a resource group in Azure with the specified name and location
resource "azurerm_resource_group" "rg" {
  name     = local.rgname
  location = var.location
}

# generates a random string of 8 characters without special characters and uppercase letters for the storage account name
resource "random_string" "random_string" {
  length  = 5
  special = false
  upper   = false
}

# reusable modules for storage, storage, networking, mssql database and app. Each module is defined in its own directory
module "storage" {
  source             = "../modules/storage"
  saname             = "${lower(local.saname)}${random_string.random_string.result}"
  rgname             = azurerm_resource_group.rg.name
  location           = azurerm_resource_group.rg.location
  storage_tiers      = var.storage_tiers
  sa_replicationtype = var.sa_replicationtype
  min_tls_version    = var.min_tls_version
}

module "networking" {
  source   = "../modules/networking"
  rgname   = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  vnetname = var.vnetname
  snname   = var.snname
  nsgname  = var.nsgname
}

module "database" {
  source                   = "../modules/database"
  rgname                   = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sql_admin_username       = var.sql_admin_username
  sql_admin_password       = var.sql_admin_password
  sql_server_name          = "${lower(var.sql_server_name)}-${random_string.random_string.result}"
  sql_database_name        = var.sql_database_name
  database_sku_name        = var.database_sku_name
  enclave_type             = var.enclave_type
  sql_database_size_gb     = var.sql_database_size_gb
  audit_storage_access_key = module.storage.storage_account_primary_access_key
  audit_storage_endpoint   = module.storage.storage_account_endpoint
  depends_on               = [module.storage]
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