output "subnet_id" {
  value       = azurerm_subnet.subnet.id
  description = "ID of the subnet"
}

output "vnetname" {
  value       = azurerm_virtual_network.vnet.name
  description = "Name of the virtual network"
}

output "nsg_id" {
  value       = azurerm_network_security_group.nsg.id
  description = "id of the network security group"
}