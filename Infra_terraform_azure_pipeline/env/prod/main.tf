module "resource_group" {
  source         = "../../modules/azurerm_resource_group"
  resource_group = var.parent_resource_group
}

module "storage_account" {
  depends_on      = [module.resource_group]
  source          = "../../modules/azurerm_stg"
  storage_account = var.parent_storage_account
}

module "virtual_network" {
  depends_on      = [module.resource_group]
  source          = "../../modules/azurerm_virtual_network"
  virtual_network = var.parent_virtual_network
}
module "network_interface" {
  depends_on        = [module.virtual_network]
  source            = "../../modules/azurerm_network_interface"
  network_interface = var.parent_network_interface
}
module "nsg" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_nsg"
  nsg        = var.parent_nsg
}

module "pip" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_pip"
  pip        = var.parent_pip
  
}

module "virtual_machine" {
  depends_on = [module.network_interface, module.nsg, module.keyvault,module.key_secrets ]
  source     = "../../modules/azurerm_virtual_machine"
  vms        = var.parent_vms
}

module "keyvault" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_keyvault"
  keyvault   = var.parent_keyvault
}

 module "key_secrets" {
  depends_on = [module.keyvault, module.resource_group]
  source     = "../../modules/azurerm_key_secrets"
  secrets    = var.parent_secrets
}



module "mssql_server" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_mssql_server"
  servers    = var.parent_sql_server
}

module "mssql_database" {
  depends_on = [module.mssql_server, module.resource_group]
  source     = "../../modules/azurerm_mssql_database"
  database   = var.parent_sql_database
}

module "nic_nsg_association" {
  depends_on               = [module.network_interface, module.nsg]
  source                   = "../../modules/azurerm_nic_nsg_association"
  child_nic_nsg_association = var.parent_nic_nsg_association
}

module "bastion" {
  depends_on = [module.virtual_network, module.resource_group, module.pip]
  source     = "../../modules/azurerm_bastion"
  bastion    = var.parent_bastion
}

module "aks" {
  depends_on          = [module.resource_group]
  source              = "../../modules/azurerm_aks"
  child_aks_clusters = var.parent_aks_clusters
}

module "lb" {
  depends_on = [module.resource_group, module.pip]
  source     = "../../modules/azurerm_lb"
  child_lb   = var.parent_lb
}
module "lb_bp_nic_association" {
  depends_on               = [module.lb, module.network_interface]
  source                   = "../../modules/azurerm_lb_bp_nic_association"
  child_lb_bp_nic_assc    = var.parent_lb_bp_nic_association
}