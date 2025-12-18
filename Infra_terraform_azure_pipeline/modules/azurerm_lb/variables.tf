variable "child_lb" {
  type = map(object({
    lb_name                           = string
    location                          = string
    rg_name                           = string
    public_ip_name                    = string
    frontend_ip_configuration_name    = string
    backend_address_pool_name         = string
    health_probe_name                 = string
    health_probe_port                 = number
    lb_rule_name                      = string
    lb_rule_protocol                  = string
    frontend_port                     = number
    backend_port                      = number
  }))
  
}