variable "rgs" {
  description = "The Configuration details of the Resource Group"
  type = map(object({
    resource_group_name = string
    resource_group_location = string
    managed_by = optional(string)
    tags = optional(map(object(
      {
        value       = string
        description = optional(string)
      }
    )),{})

  }))
}