resource "azurerm_mssql_server" "sqlserver" {
    name                         = var.sql_server_name
    resource_group_name          = var.rgname
    location                     = var.location
    version                      = "12.0"
    administrator_login          = var.sql_admin_username
    administrator_login_password = var.sql_admin_password
    public_network_access_enabled = false
    minimum_tls_version = "1.0"
}

resource "azurerm_mssql_server_extended_auditing_policy" "audit_policy" {
  server_id                    = azurerm_mssql_server.sqlserver.id
  storage_endpoint             = var.audit_storage_endpoint
  storage_account_access_key   = var.audit_storage_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days            = 30  # Customize the retention period based on requirements
}

resource "azurerm_mssql_database" "sqldatabase" {
  name         = var.sql_database_name
  server_id    = azurerm_mssql_server.sqlserver.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = var.sql_database_size_gb
  sku_name     = var.database_sku_name
  enclave_type = var.enclave_type

  tags = {
    foo = "bar"
  }

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = false
  }
}