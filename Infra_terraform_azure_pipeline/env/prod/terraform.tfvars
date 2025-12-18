parent_resource_group = {
  "rg" = {
    rg_name  = "prod-rg-justice"
    location = "central india"
    tags = {
      environment = "production"
      project     = "avengers"
    }
  }
}


parent_storage_account = {
  "stg" = {
    name                             = "prodstgacctjustice012"
    resource_group_name              = "prod-rg-justice"
    location                         = "central india"
    account_tier                     = "Standard"
    account_replication_type         = "LRS"
    cross_tenant_replication_enabled = false

  }
}

parent_virtual_network = {
  "vnet1" = {
    vnet_name     = "prod-vnet-justice"
    rg_name       = "prod-rg-justice"
    location      = "central india"
    address_space = ["10.0.0.0/16"]
    dns_servers   = ["8.8.8.8", "4.4.2.2"]
    tags = {
      environment = "production"
      project     = "avengers"
    }

    subnets = [
      {
        subnet_name      = "subnet-frontend"
        address_prefixes = ["10.0.1.0/24"]
      },
      {
        subnet_name      = "subnet-backend"
        address_prefixes = ["10.0.2.0/24"]
      },
      {
        subnet_name      = "AzureBastionSubnet"
        address_prefixes = ["10.0.3.0/24"]
      }
    ]
  }
}

parent_network_interface = {
  "nic1" = {
    nic_name    = "prod-nic-justice-01"
    location    = "central india"
    rg_name     = "prod-rg-justice"
    dns_servers = ["8.8.8.8", "4.4.2.2"]
    subnet_name = "subnet-frontend"
    vnet_name   = "prod-vnet-justice"
    tags = {
      environment = "production"
      project     = "avengers"
    }
    ip_configuration = [
      {
        ip_configuration_name         = "to-ipconfig-01"
        private_ip_address_allocation = "Dynamic"
      }
    ]
  }
  nic2 = {
    nic_name    = "prod-nic-justice-02"
    location    = "central india"
    rg_name     = "prod-rg-justice"
    dns_servers = ["8.8.8.8", "4.4.2.2"]
    subnet_name = "subnet-backend"
    vnet_name   = "prod-vnet-justice"
    tags = {
      environment = "production"
      project     = "avengers"
    }
    ip_configuration = [
      {
        ip_configuration_name         = "to-ipconfig-02"
        private_ip_address_allocation = "Dynamic"
      }
    ]
  }
}


parent_pip = {
  "bastion" = {
    name                 = "prod-bastion-pip-01"
    rg_name              = "prod-rg-justice"
    location             = "central india"
    allocation_method    = "Static"
    ddos_protection_mode = "Disabled"
    tags = {
      environment = "production"
      project     = "justice"
    }
  }
  lb_pip = {
    name                 = "prod-lb-pip-01"
    rg_name              = "prod-rg-justice"
    location             = "central india"
    allocation_method    = "Static"
    ddos_protection_mode = "Disabled"
    tags = {
      environment = "production"
      project     = "justice"
    }
  }
}
parent_nsg = {
  "nsg1" = {
    nsg_name    = "prod-nsg-justice-01"
    rg_name     = "prod-rg-justice"
    location    = "central india"
    description = "NSG for justice project in production"
    tags = {
      environment = "production"
      project     = "justice"
    }
    security_rule = [
      {
        nsg_rule_name              = "allow-ssh"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        nsg_rule_name              = "allow-http"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

parent_vms = {
  vm1 = {
    vm_name      = "prod-vm-avengers-01"
    size         = "Standard_B1s"
    rg_name      = "prod-rg-justice"
    location     = "central india"
    key_name     = "prodkvjustice03"
    secret_name  = "vmavengers1"
    secret_value = "password1"
    nic_name     = "prod-nic-justice-01"
    os_disk = [
      {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
    ]
    source_image_reference = [
      {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
      }
    ]
    custom_data_script = <<-EOT
    #!/bin/bash
      apt update -y
      apt upgrade -y
      apt install nginx -y
      rm -rf  /var/www/html/*
      git clone https://github.com/devopsinsiders/starbucks-clone.git /var/www/html/
      systemctl enable nginx
      systemctl start nginx
    EOT
  }
  vm2 = {
    vm_name      = "prod-vm-avengers-02"
    size         = "Standard_B1s"
    rg_name      = "prod-rg-justice"
    location     = "central india"
    key_name     = "prodkvjustice03"
    secret_name  = "vmavengers2"
    secret_value = "password2"
    nic_name     = "prod-nic-justice-02"
    os_disk = [
      {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
    ]
    source_image_reference = [
      {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
      }
    ]
    custom_data_script = <<-EOT
    #!/bin/bash
      apt update -y
      apt upgrade -y
      apt install nginx -y
      rm -rf  /var/www/html/*
      git clone https://github.com/devopsinsiders/starbucks-clone.git /var/www/html/
      systemctl enable nginx
      systemctl start nginx
    EOT
  }
}




parent_keyvault = {
  "kv1" = {
    name                       = "prodkvjustice03"
    rg_name                    = "prod-rg-justice"
    location                   = "central india"
    sku_name                   = "standard"
    purge_protection_enabled   = false
    soft_delete_retention_days = 7

    enabled_for_disk_encryption = true

    tags = {
      environment = "production"
      project     = "avengers"
    }
  }
}

parent_secrets = {
  vmsec1 = {
    key_name     = "prodkvjustice03"
    rg_name      = "prod-rg-justice"
    secret_name  = "vmavengers1"
    secret_value = "virtual@123"
  }
  vmsec2 = {
    key_name     = "prodkvjustice03"
    rg_name      = "prod-rg-justice"
    secret_name  = "vmavengers2"
    secret_value = "virtual@12345"
  }
  sqlsec1 = {
    key_name     = "prodkvjustice03"
    rg_name      = "prod-rg-justice"
    secret_name  = "sqlavengers001"
    secret_value = "admin@123"
  }
  secret4 = {
    key_name     = "prodkvjustice03"
    rg_name      = "prod-rg-justice"
    secret_name  = "vm3pending"
    secret_value = "virtual@12345"
  }
}

parent_sql_server = {
  sql1 = {
    name                          = "sqlavengers001"
    rg_name                       = "prod-rg-justice"
    location                      = "central india"
    version                       = "12.0"
    administrator_login           = "sqladminuser"
    administrator_login_password  = "Sql@12345678"
    public_network_access_enabled = true
    tags = {
      environment = "prod"
      team        = "todappteam"
    }
  }
}


parent_sql_database = {
  db1 = {
    name         = "sqlavengersdb001"
    server_name  = "sqlavengers001"
    rg_name      = "prod-rg-justice"
    collation    = "SQL_Latin1_General_CP1_CI_AS"
    license_type = "LicenseIncluded"
    max_size_gb  = 2
    sku_name     = "S0"
    enclave_type = "VBS"
  }
}

parent_nic_nsg_association = {
  association1 = {
    nic_name = "prod-nic-justice-01"
    nsg_name = "prod-nsg-justice-01"
    rg_name  = "prod-rg-justice"
  }
  association2 = {
    nic_name = "prod-nic-justice-02"
    nsg_name = "prod-nsg-justice-01"
    rg_name  = "prod-rg-justice"
  }
}
parent_bastion = {
  bastion1 = {
    bastion_name     = "prod-bastion-justice-01"
    rg_name          = "prod-rg-justice"
    location         = "central india"
    vnet_name        = "prod-vnet-justice"
    subnet_name      = "AzureBastionSubnet"
    bastion_pip_name = "prod-bastion-pip-01"

    tags = {
      environment = "production"
      project     = "avengers"
    }

    bastion_ip_config = {
      ipconfig1 = {
        name = "bastion-ipconfig-01"
      }
    }
  }
}

parent_aks_clusters = {
  aks1 = {
    aks_name           = "prodaks01"
    rg_name            = "prod-rg-justice"
    location           = "central india"
    dns_prefix         = "prodaksjustice"
    node_count         = 1
    vm_size            = "Standard_B4s_v2"
    kubernetes_version = "1.32.9"

    tags = {
      environment = "production"
      project     = "avengers"
    }
  }
}

parent_lb = {
  lb1 = {
    lb_name                        = "prod-lb-justice-01"
    rg_name                        = "prod-rg-justice"
    location                       = "central india"
    frontend_ip_configuration_name = "prod-frontend-ipconfig-01"
    backend_address_pool_name      = "prod-backend-pool-01"
    health_probe_name              = "prod-health-probe-01"
    health_probe_port              = 80
    lb_rule_name                   = "prod-lb-rule-01"
    lb_rule_protocol               = "Tcp"
    frontend_port                  = 80
    backend_port                   = 80
    public_ip_name                 = "prod-lb-pip-01"
    sku_type                       = "Standard"
    sku_capacity                   = 2

    tags = {
      environment = "production"
      project     = "avengers"
    }
  }
}

parent_lb_bp_nic_association = {
  assoc1 = {
    nic_name                  = "prod-nic-justice-01"
    rg_name                   = "prod-rg-justice"
    loadbalancer_name         = "prod-lb-justice-01"
    backend_address_pool_name = "prod-backend-pool-01"
    ip_configuration_name     = "to-ipconfig-01"
  }
  assoc2 = {
    nic_name                  = "prod-nic-justice-02"
    rg_name                   = "prod-rg-justice"
    loadbalancer_name         = "prod-lb-justice-01"
    backend_address_pool_name = "prod-backend-pool-01"
    ip_configuration_name     = "to-ipconfig-02"
  }
}