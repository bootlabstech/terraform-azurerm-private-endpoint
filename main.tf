resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "service" {
  name                 = var.service_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_prefixes

  enforce_private_link_service_network_policies = true
}

resource "azurerm_subnet" "endpoint" {
  name                 = var.endpoint_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.endpoint_address_prefixes

  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  sku                 = "Standard"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_lb" "lb" {
  name                = var.lb_name
  sku                 = "Standard"
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = azurerm_public_ip.public_ip.name
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_private_link_service" "privatelink" {
  name                = var.privatelink_name
  location            = var.location
  resource_group_name = var.resource_group_name

  nat_ip_configuration {
    name      = azurerm_public_ip.public_ip.name
    primary   = true
    subnet_id = azurerm_subnet.service.id
  }

  load_balancer_frontend_ip_configuration_ids = [
    azurerm_lb.lb.frontend_ip_configuration.0.id,
  ]
}

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.endpoint.id

  private_service_connection {
    name                           = var.privateserviceconnection_name
    private_connection_resource_id = azurerm_private_link_service.privatelink.id
    is_manual_connection           = false
  }
}
