resource "azurerm_public_ip" "public_ip" {
  for_each = var.vms
  name                = each.value.public_ip_address_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku               = "Standard"
}
resource "azurerm_network_interface" "myNIC" {
  depends_on = [azurerm_public_ip.public_ip ,data.azurerm_subnet.mySubnet ]
  for_each = var.vms
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.mySubnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip[each.key].id
  }
}
resource "azurerm_linux_virtual_machine" "myVM" {
  depends_on = [azurerm_network_interface.myNIC]
  for_each = var.vms
  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = data.azurerm_key_vault_secret.myvmusername[each.key].value
  admin_password      = data.azurerm_key_vault_secret.myvmpassword[each.key].value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.myNIC[each.key].id,
  ]

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }
  custom_data = base64encode(file(each.value.custom_data))
}