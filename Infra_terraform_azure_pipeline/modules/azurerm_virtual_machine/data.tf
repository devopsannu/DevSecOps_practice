data "azurerm_network_interface" "data_nic" {
  for_each            = var.vms
  name                = each.value.nic_name
  resource_group_name = each.value.rg_name
}

data "azurerm_key_vault" "data_keyid" {
  for_each            = var.vms
  name                = each.value.key_name
  resource_group_name = each.value.rg_name
}

data "azurerm_key_vault_secret" "admin_name" {
  for_each = var.vms
  name         = each.value.secret_name
  key_vault_id = data.azurerm_key_vault.data_keyid[each.key].id
}

data "azurerm_key_vault_secret" "admin_password" {
  for_each = var.vms
  # name         = each.value.secret_value
  name         = each.value.secret_name
  key_vault_id = data.azurerm_key_vault.data_keyid[each.key].id
}

