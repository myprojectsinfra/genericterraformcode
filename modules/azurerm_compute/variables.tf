variable "vms" {
  description = "The configuration of the virtual machine"
  type = map(object({
    nic_name               = string
    location               = string
    resource_group_name    = string
    virtual_network_name   = string
    subnet_name            = string
    public_ip_address_name = string
    vm_name                = string
    size                   = string
    admin_username         = string
    admin_password         = string
    os_disk = object({
      caching              = string
      storage_account_type = string
    })
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })

  }))
}