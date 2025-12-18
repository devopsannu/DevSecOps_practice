data "azurerm_key_vault" "data_keyid" {
  for_each            = var.secrets
  name                = each.value.key_name
  resource_group_name = each.value.rg_name
}

