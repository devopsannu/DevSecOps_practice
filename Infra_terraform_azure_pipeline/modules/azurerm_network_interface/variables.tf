variable "network_interface" {
  description = "A map of network interface configurations."
  type = map(object({
    nic_name    = string
    location    = string
    rg_name     = string
    dns_servers = optional(list(string))
    ip_configuration = list(object({
      ip_configuration_name         = string
      private_ip_address_allocation = string
    }))
    subnet_name = string
    vnet_name   = string
    tags        = map(string)
  }))

}
