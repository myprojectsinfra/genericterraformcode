rgs = {
  rg1 = {
    resource_group_name     = "ankitdevrg1"
    resource_group_location = "eastus"
    managed_by              = "Terraform"
    tags = {
      environment = {
        value       = "development"
        description = "Dev Environment"
      }
      owner = {
        value = "Ankit Kumar"
      }
    }

  }
  # rg2 = {
  #   resource_group_name     = "ankitdevrg2"
  #   resource_group_location = "westus"
  #   managed_by              = "Terraform"
  #   tags = {
  #     environment = {
  #       value       = "production"
  #       description = "Prod Environment"
  #     }
  #     owner = {
  #       value = "Anshu Kumar"
  #     }
  #   }

  # }

}

networks = {
  vnet1 = {
    virtual_network_name     = "ankitvnet1"
    resource_group_name      = "ankitdevrg1"
    virtual_network_location = "eastus"
    address_space            = ["192.168.0.0/16"]
    subnets = {
      subnetfront = {
        subnet_name      = "subnetfrontend"
        address_prefixes = ["192.168.1.0/24"]
      }
      subnetbackend = {
        subnet_name      = "subnetbackend"
        address_prefixes = ["192.168.2.0/24"]
      }
    }
    tags = {
      environment = {
        value       = "development"
        description = "This Virtual network for development environment"
      }
    }

  }
}

vms = {
  vms1 = {
    nic_name             = "frontendnic"
    location             = "eastus"
    resource_group_name  = "ankitdevrg1"
    virtual_network_name = "ankitvnet1"
    subnet_name          = "subnetfrontend"
    public_ip_address_name = "frontendpublicip"
    vm_name              = "frontend-vm"
    size                 = "Standard_B1s"
    admin_username       = "ankitadmin"
    admin_password       = "Admin@123#"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
}
