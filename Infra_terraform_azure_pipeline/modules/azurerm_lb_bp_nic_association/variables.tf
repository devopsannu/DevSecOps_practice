variable "child_lb_bp_nic_assc" {
  type = map(object({
    nic_name                     = string
    rg_name                      = string
    loadbalancer_name            = string
    backend_address_pool_name    = string
    ip_configuration_name        = string
  }))
  
}