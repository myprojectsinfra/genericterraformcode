data "azurerm_subnet" "mySubnet" {
  for_each = var.vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_key_vault" "mydatakv" {
  for_each = var.vms
  name                = each.value.key_vault_name
  resource_group_name = each.value.key_vault_rg_name
}
data "azurerm_key_vault_secret" "myvmusername" {
  for_each = var.vms
  name         = each.value.key_vault_user
  key_vault_id = data.azurerm_key_vault.mydatakv[each.key].id
}

data "azurerm_key_vault_secret" "myvmpassword" {
  for_each = var.vms
  name         = each.value.key_vault_pass
  key_vault_id = data.azurerm_key_vault.mydatakv[each.key].id
}
