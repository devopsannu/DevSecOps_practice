variable "bastion" {
  description = "A map of Bastion Host configurations"
  type = map(object({
    bastion_name        = string
    rg_name            = string
    location           = string
    vnet_name          = string
    subnet_name        = string
    bastion_pip_name   = string
    bastion_ip_config  = map(object({
      name = string
    }))
    tags = map(string)
  }))
}
