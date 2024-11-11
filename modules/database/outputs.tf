output "sql_server_name" {
  value = azurerm_mssql_server.sqlserver.name
}

output "sql_database_name" {
  value = azurerm_mssql_database.sqldatabase.name
}

output "sql_server_fqdn" {
  value = azurerm_mssql_server.sqlserver.fully_qualified_domain_name
}