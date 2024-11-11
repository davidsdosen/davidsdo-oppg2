# Creates a virtual network, fundamental building block for networking in Azure
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnetname
  location            = var.location
  resource_group_name = var.rgname
  address_space       = var.address_space
  dns_servers         = var.dns_servers
}

# subnet within the virtual network to segment the network into multiple sub-networks 
resource "azurerm_subnet" "subnet" {
  name                 = var.snname
  resource_group_name  = var.rgname
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_prefixes
}

# network security group contains a list of security rules that allow or deny inbound or outbound network traffic to resources connected to Azure Virtual Networks
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.vnetname}-nsg"
  location            = var.location
  resource_group_name = var.rgname


  security_rule {
    name                       = "tf-davidsdo-security-rules"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# associates a network security group with a subnet so the security rules can be applied to the resources connected to the subnet
resource "azurerm_subnet_network_security_group_association" "davidsdo-nsg_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}