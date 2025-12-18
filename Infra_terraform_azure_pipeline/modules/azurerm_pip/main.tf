resource "azurerm_public_ip" "pip_justice" {
  for_each             = var.pip
  name                 = each.value.name
  resource_group_name  = each.value.rg_name
  location             = each.value.location
  allocation_method    = each.value.allocation_method
  ddos_protection_mode = each.value.ddos_protection_mode
  tags                 = each.value.tags
}


