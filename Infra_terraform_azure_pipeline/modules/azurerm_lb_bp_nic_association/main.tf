data "azurerm_network_interface" "nic_data" {
  for_each            = var.child_lb_bp_nic_assc
  name                = each.value.nic_name
  resource_group_name = each.value.rg_name

}

data "azurerm_lb" "lb_data" {
  for_each            = var.child_lb_bp_nic_assc
  name                = each.value.loadbalancer_name
  resource_group_name = each.value.rg_name

}

data "azurerm_lb_backend_address_pool" "bp_data" {
  for_each        = var.child_lb_bp_nic_assc
  name            = each.value.backend_address_pool_name
  loadbalancer_id = data.azurerm_lb.lb_data[each.key].id
}
resource "azurerm_network_interface_backend_address_pool_association" "bp_nic_assc" {
  for_each                = var.child_lb_bp_nic_assc
  network_interface_id    = data.azurerm_network_interface.nic_data[each.key].id
  ip_configuration_name   = each.value.ip_configuration_name
  backend_address_pool_id = data.azurerm_lb_backend_address_pool.bp_data[each.key].id
}
