resource "azurerm_mssql_server" "sqlserver" {
    name                         = var.sql_server_name
    resource_group_name          = var.rgname
    location                     = var.location
    version                      = "12.0"
    administrator_login          = var.sql_admin_username
    administrator_login_password = var.sql_admin_password
    public_network_access_enabled = false
    minimum_tls_version = "TLS1_2"
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