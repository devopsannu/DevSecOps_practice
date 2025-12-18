variable "parent_resource_group" {
  description = "resource group for avengers project"
  type = map(object({
    rg_name  = string
    location = string

    tags = optional(map(string))
  }))

}

variable "parent_storage_account" {

  description = "Sstorage account for avengers project"
  type = map(object({
    name                             = string ## Thesre are the required names
    resource_group_name              = string
    location                         = string
    account_tier                     = string
    account_replication_type         = string
    cross_tenant_replication_enabled = optional(bool) ## This is an optional parameter

  }))
}
variable "parent_virtual_network" {
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
variable "parent_network_interface" {
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

variable "parent_pip" {
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
variable "parent_nsg" {
 description = "network security group for justice project"
  type = map(object({
    nsg_name = string
    rg_name  = string
    location = string

    tags = optional(map(string))
    security_rule = list(object({
      nsg_rule_name              = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))

}
variable "parent_vms" {
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
variable "parent_keyvault" {
type = map(object({
    name                        = string
    rg_name                     = string
    enabled_for_disk_encryption = bool
    location                    = string
    purge_protection_enabled    = bool
    soft_delete_retention_days  = number
    sku_name                    = string
  }))
}
variable "parent_secrets" {
 type = map(object({
    key_name            = string
    rg_name             = string
    secret_name         = string
    secret_value        = string
  }))
}
variable "parent_sql_server" {
 type = map(object({
    name                          = string
    rg_name                       = string
    location                      = string
    version                       = string
    public_network_access_enabled = bool
    administrator_login           = optional(string)
    administrator_login_password  = optional(string)
    minimum_tls_version           = optional(string)
    tags                          = optional(map(string))
    azuread_administrators = optional(list(object({
      login_username = string
      object_id      = string
    })))
  }))
}
variable "parent_sql_database" {
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
variable "parent_nic_nsg_association" {
 description = "A map of NIC to NSG associations"
  type = map(object({
    nic_name = string
    nsg_name = string
    rg_name  = string
  }))
}
variable "parent_bastion" {
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

variable "parent_aks_clusters" {
type = map(object({
    aks_name            = string
    location            = string
    rg_name = string
    dns_prefix          = string
    node_count          = number
    vm_size             = string
    kubernetes_version  = optional(string)
    tags                = optional(map(string))
  }))
}
variable "parent_lb" {
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
variable "parent_lb_bp_nic_association" {
 type = map(object({
    nic_name                     = string
    rg_name                      = string
    loadbalancer_name            = string
    backend_address_pool_name    = string
    ip_configuration_name        = string
  }))
}
