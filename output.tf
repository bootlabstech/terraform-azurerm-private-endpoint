output "azurerm_virtual_network" {
  value = azurerm_virtual_network.vnet
}

output "azurerm_public_ip" {
  value = azurerm_public_ip.public_ip
}

output "azurerm_lb" {
  value = azurerm_lb.lb
}

output "azurerm_private_link_service" {
  value = azurerm_private_link_service.privatelink
}
