variable "servers" {
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

## # Variable for SQL Servers
# variable "sql_servers" {
#   description = "Map of SQL Server configurations"
#   type = map(object({
#     sqlservername                 = string
#     rg_name                       = string
#     location                      = string
#     version                       = string
#     server_login_username         = string
#     server_login_password         = string
#     public_network_access_enabled = optional(bool, false)
#   }))
# }
