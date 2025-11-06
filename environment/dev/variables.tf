variable "rgs" {
  description = "The Configuration details of the Resource Group"
  type = map(object({
    resource_group_name     = string
    resource_group_location = string
    managed_by              = optional(string)
    tags = optional(map(object(
      {
        value       = string
        description = optional(string)
      }
    )), {})

  }))
}
variable "networks" {
  description = "The Configuration of Virtual Networks"
  type = map(object(
    {
      virtual_network_name     = string
      resource_group_name      = string
      virtual_network_location = string
      address_space            = list(string)
      subnets = optional(map(object(
        {
          subnet_name      = string
          address_prefixes = list(string)
        }
      )), {})
      tags = optional(map(object(
        {
          value       = string
          description = optional(string)
        }
      )), {})
    }
  ))

}

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