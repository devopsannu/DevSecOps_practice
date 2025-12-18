resource "azurerm_resource_group" "rg-justice" {
  for_each   = var.resource_group
  name       = each.value.rg_name
  location   = each.value.location
  tags       = each.value.tags

}
