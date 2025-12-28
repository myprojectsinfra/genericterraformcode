module "rg_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}
module "networks" {
  depends_on = [module.rg_group]
  source     = "../../modules/azurerm_virtual_network"
  networks   = var.networks
}
module "compute" {
  depends_on = [module.rg_group, module.networks]
  source     = "../../modules/azurerm_compute"
  vms        = var.vms
}
module "dbstore" {
  depends_on = [module.rg_group, module.networks]
  source     = "../../modules/azurerm_dbstore"
  dbstore    = var.dbstore
}

module "security" {
  depends_on = [module.rg_group, module.networks, module.compute]
  source     = "../../modules/azurerm_security"
  nsg_config = var.nsg_config
}