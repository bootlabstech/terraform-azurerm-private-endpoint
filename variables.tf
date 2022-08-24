variable "resource_group_name" {
  type        = string
  description = "name of the resource group"
}

variable "location" {
  type        = string
  description = "location of the resource group"
}

variable "vnet_name" {
  type        = string
  description = "name of the azurerm_virtual_network"
}

variable "service_name" {
  type        = string
  description = "name of the azurerm_subnet"
}

variable "endpoint_name" {
  type        = string
  description = "name of the azurerm_subnet"
}

variable "public_ip_name" {
  type        = string
  description = "name of the azurerm_public_ip"
}

variable "lb_name" {
  type        = string
  description = "name of the azurerm_lb"
}

variable "privatelink_name" {
  type        = string
  description = "name of the azurerm_private_link_service"
}

variable "private_endpoint_name" {
  type        = string
  description = "name of the azurerm_private_endpoint"
}
