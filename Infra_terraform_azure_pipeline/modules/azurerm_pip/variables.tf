variable "pip" {
  description = "A map of Public IP configurations"
  type = map(object({
    name                 = string
    rg_name             = string
    location            = string
    allocation_method   = string
    ddos_protection_mode = string
    tags                = map(string)
  }))
}
