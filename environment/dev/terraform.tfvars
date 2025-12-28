rgs = {
  rg1 = {
    resource_group_name     = "todoappinfra-rg"
    resource_group_location = "switzerlandnorth"
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


}

networks = {
  vnet1 = {
    virtual_network_name     = "todoappvnet"
    resource_group_name      = "todoappinfra-rg"
    virtual_network_location = "switzerlandnorth"
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
  frontvm = {
    nic_name               = "frontendnic"
    location               = "switzerlandnorth"
    resource_group_name    = "todoappinfra-rg"
    virtual_network_name   = "todoappvnet"
    subnet_name            = "subnetfrontend"
    key_vault_rg_name      = "mybackendrg"
    key_vault_name         = "monoappsecretsKv"
    key_vault_user         = "frontusername"
    key_vault_pass         = "frontpassword"
    public_ip_address_name = "frontendpublicip"
    vm_name                = "frontend-vm"
    size                   = "Standard_D4s_v3"
    custom_data            = "frontend.sh"
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

dbstore = {
  dataStore1 = {
    resource_group_name = "todoappinfra-rg"
    sql_server_location = "switzerlandnorth"
    sql_server_name     = "todoappinfra-dbserver"
    sql_database_name   = "todoappinfra-database"
    key_vault_rg_name   = "mybackendrg"
    key_vault_name      = "monoappsecretsKv"
    key_vault_user      = "dbusername"
    key_vault_pass      = "dbpassword"


  }
}

nsg_config = {
  nsg1 = {
    nsg_name             = "todomynsg"
    nsg_location         = "switzerlandnorth"
    resource_group_name  = "todoappinfra-rg"
    subnet_name          = "subnetfrontend"
    virtual_network_name = "todoappvnet"
  }
}
  