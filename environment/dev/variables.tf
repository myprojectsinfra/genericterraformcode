variable "subscription_id" {
  description = "The subscription id"
  type = string
}
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
    key_vault_rg_name      = string
    key_vault_name         = string
    key_vault_user         = string
    key_vault_pass         = string
    custom_data            = string
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

variable "dbstore" {
  description = "The configuration of the database and database server"
  type = map(object({
    resource_group_name = string
    sql_server_location = string
    sql_server_name     = string
    sql_database_name   = string
    key_vault_rg_name   = string
    key_vault_name      = string
    key_vault_user      = string
    key_vault_pass      = string

  }))
}

variable "nsg_config" {
  description = "The configuration of NSG and Subnet"
  type = map(object({
    nsg_name             = string
    resource_group_name  = string
    nsg_location         = string
    subnet_name          = string
    virtual_network_name = string

  }))
}
