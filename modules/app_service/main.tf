resource "azurerm_service_plan" "splan" {
  name                = var.splan_name
  resource_group_name = var.rgname
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.appservice_sku_name
}


resource "azurerm_public_ip" "public_ip" {
  name                = "${var.splan_name}-publicip"
  location            = var.location
  resource_group_name = var.rgname
  allocation_method   = "Static"
}

resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.rgname

  frontend_ip_configuration {
    name                 = azurerm_public_ip.public_ip.name
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}