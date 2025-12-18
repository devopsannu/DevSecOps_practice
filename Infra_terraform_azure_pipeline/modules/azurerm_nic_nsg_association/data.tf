
data "azurerm_network_interface" "data_nic" {
  for_each            = var.child_nic_nsg_association
  name                = each.value.nic_name
  resource_group_name = each.value.rg_name
}

data "azurerm_network_security_group" "nsg_data" {
  for_each            = var.child_nic_nsg_association
  name                = each.value.nsg_name
  resource_group_name = each.value.rg_name
}