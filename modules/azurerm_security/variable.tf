variable "nsg_config" {
  description = "The configuration of NSG and subnet"
  type = map(object({
    nsg_name = string
    resource_group_name = string
    nsg_location = string
    subnet_name     = string
    virtual_network_name     = string

  }))
}