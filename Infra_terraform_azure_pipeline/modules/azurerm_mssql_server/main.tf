# resource "azurerm_mssql_server" "sql_server" {
#   for_each = var.sql_servers

#   name                         = each.value.sqlservername
#   resource_group_name          = each.value.rg_name
#   location                     = each.value.location
#   version                      = each.value.version
#   administrator_login          = each.value.server_login_username
#   administrator_login_password = each.value.server_login_password

#   public_network_access_enabled = lookup(each.value, "public_network_access_enabled", false)
# }

resource "azurerm_mssql_server" "mysql_server" {

  for_each                      = var.servers
  name                          = each.value.name
  resource_group_name           = each.value.rg_name
  location                      = each.value.location
  version                       = each.value.version
  administrator_login           = each.value.administrator_login
  administrator_login_password  = each.value.administrator_login_password
  minimum_tls_version           = each.value.minimum_tls_version
  public_network_access_enabled = each.value.public_network_access_enabled


  dynamic "azuread_administrator" {
    for_each = each.value.azuread_administrators == null ? [] : each.value.azuread_administrator
    content {
      login_username = azuread_administrator.value.login_username
      object_id      = azuread_administrator.value.object_id
    }
  }

  tags = each.value.tags
}
