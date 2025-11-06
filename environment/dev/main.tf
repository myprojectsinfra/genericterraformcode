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
  vms   = var.vms
}