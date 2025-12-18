variable "storage_account" {
  description = "Sstorage account for avengers project"
  type = map(object({
    name                             = string   ## Thesre are the required names
    resource_group_name              = string   
    location                         = string
    account_tier                     = string
    account_replication_type         = string
    cross_tenant_replication_enabled = optional(bool)     ## This is an optional parameter
  
  }))
  
}