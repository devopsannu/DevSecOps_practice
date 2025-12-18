resource "azurerm_lb" "lb" {
  for_each            = var.child_lb
  name                = each.value.lb_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  frontend_ip_configuration {
    name                 = each.value.frontend_ip_configuration_name
    public_ip_address_id = data.azurerm_public_ip.pip_data[each.key].id
  }
}

resource "azurerm_lb_backend_address_pool" "bpool" {
  for_each        = var.child_lb
  loadbalancer_id = azurerm_lb.lb[each.key].id
  name            = each.value.backend_address_pool_name
}

resource "azurerm_lb_probe" "health_probe" {
  for_each        = var.child_lb
  loadbalancer_id = azurerm_lb.lb[each.key].id
  name            = each.value.health_probe_name
  port            = each.value.health_probe_port
}

resource "azurerm_lb_rule" "lb_rule" {
  for_each                       = var.child_lb
  loadbalancer_id                = azurerm_lb.lb[each.key].id
  name                           = each.value.lb_rule_name
  protocol                       = each.value.lb_rule_protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bpool[each.key].id]
  probe_id                       = azurerm_lb_probe.health_probe[each.key].id
}
