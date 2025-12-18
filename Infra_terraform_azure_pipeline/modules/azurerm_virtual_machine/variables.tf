variable "vms" {
  type = map(object({
    vm_name      = string
    size         = string
    rg_name      = string
    location     = string
    key_name     = string
    secret_name  = string
    secret_value = string
    nic_name     = string
    os_disk = list(object({
      caching              = string
      storage_account_type = string
    }))
    source_image_reference = list(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }))

    custom_data_script = optional(string)
  }))
}
