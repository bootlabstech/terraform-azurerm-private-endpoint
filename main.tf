# Creates  a private endpoint with private dns
resource "azurerm_private_endpoint" "endpoint" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.name}-connection"
    private_connection_resource_id = var.private_connection_resource_id
    is_manual_connection           = var.is_manual_connection
    subresource_names              = var.subresource_names

  }
  private_dns_zone_group {
    name                 = "${var.name}-dnszone"
    private_dns_zone_ids = var.private_dns_zone_ids
  }
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }

}

