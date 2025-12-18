resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bastion
  name                = each.value.bastion_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  dynamic "ip_configuration" {
    for_each = each.value.bastion_ip_config
    content {
      name                 = ip_configuration.value.name
      subnet_id            = data.azurerm_subnet.subnet_data[each.key].id
      public_ip_address_id = data.azurerm_public_ip.pip_data[each.key].id
    }
  }
}

