variable "database" {
  type = map(object({
    server_name         = string
    rg_name             = string
    name                = string
    collation           = string
    license_type        = string
    max_size_gb         = number
    sku_name            = string
    enclave_type        = string
    tags                = optional(map(string))

  }))

}
