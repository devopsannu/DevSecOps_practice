resource "azurerm_network_interface_security_group_association" "nic_nsg_association" {
  for_each                  = var.child_nic_nsg_association
  network_interface_id      = data.azurerm_network_interface.data_nic[each.key].id
  network_security_group_id = data.azurerm_network_security_group.nsg_data[each.key].id
}

