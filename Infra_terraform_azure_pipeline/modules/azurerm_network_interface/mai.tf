resource "azurerm_network_interface" "nic_justice" {
  for_each            = var.network_interface
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.rg_name
  dns_servers         = each.value.dns_servers
  tags                = each.value.tags

  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration
    content {
      name                          = ip_configuration.value.ip_configuration_name
      subnet_id                     = data.azurerm_subnet.subnet_data[each.key].id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
    }
  }
}

