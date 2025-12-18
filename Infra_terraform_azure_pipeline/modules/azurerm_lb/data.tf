data "azurerm_public_ip" "pip_data" {
  for_each            = var.child_lb
  name                = each.value.public_ip_name
  resource_group_name = each.value.rg_name
}
