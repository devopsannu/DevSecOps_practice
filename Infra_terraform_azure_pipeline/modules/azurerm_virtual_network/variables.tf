variable "virtual_network" {
  description = "virtual network for avengers project"
  type = map(object({
    vnet_name     = string
    rg_name       = string
    location      = string
    address_space = list(string)
    dns_servers   = optional(list(string))
    subnets = list(object({
      subnet_name      = string
      address_prefixes = list(string)
    
    }))
    tags = optional(map(string))
  }))

}
