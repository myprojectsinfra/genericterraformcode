resource "azurerm_network_security_group" "mynsg" {
  for_each = var.nsg_config
  name                = each.value.nsg_name
  location            = each.value.nsg_location
  resource_group_name = each.value.resource_group_name

  security_rule {
    name                       = "todosecrule"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges     = ["22", "80"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
data "azurerm_subnet" "mySubnet" {
  for_each = var.nsg_config
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}
resource "azurerm_subnet_network_security_group_association" "nsgassociation" {
  depends_on = [azurerm_network_security_group.mynsg , data.azurerm_subnet.mySubnet ]
  for_each = var.nsg_config
  subnet_id                 = data.azurerm_subnet.mySubnet[each.key].id
  network_security_group_id = azurerm_network_security_group.mynsg[each.key].id
}