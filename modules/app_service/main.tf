# hosting plan for Azure Web Apps
resource "azurerm_service_plan" "splan" {
  name                = var.splan_name
  resource_group_name = var.rgname
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.appservice_sku_name
}

# public IP address is used to provide a static public IP for resources
resource "azurerm_public_ip" "public_ip" {
  name                = "${var.splan_name}-publicip"
  location            = var.location
  resource_group_name = var.rgname
  allocation_method   = "Static"
}

# load balancer is used to distribute incoming network traffic
resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.rgname

# frontend IP for the load balancer using the static public IP created above
  frontend_ip_configuration {
    name                 = azurerm_public_ip.public_ip.name
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}