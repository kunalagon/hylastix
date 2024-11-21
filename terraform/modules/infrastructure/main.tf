# resource "random_pet" "keycloak_rg_name" {
#   prefix = var.resource_group_name_prefix
# }

resource "azurerm_resource_group" "keycloak_rg" {
  location = var.resource_group_location
  #name     = random_pet.keycloak_rg_name.id
  name	  = "HyLastixTask"
}

# Create virtual network
resource "azurerm_virtual_network" "keycloak_terraform_network" {
  name                = "Keycloak_VNet"
  address_space       = ["192.168.0.0/16"]
  location            = azurerm_resource_group.keycloak_rg.location
  resource_group_name = azurerm_resource_group.keycloak_rg.name
}

# Create subnet
resource "azurerm_subnet" "keycloak_terraform_subnet" {
  name                 = "Keycloak_Subnet"
  resource_group_name  = azurerm_resource_group.keycloak_rg.name
  virtual_network_name = azurerm_virtual_network.keycloak_terraform_network.name
  address_prefixes     = ["192.168.14.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "keycloak_public_ip" {
  name                = "Keycloak_Public_IP"
  location            = azurerm_resource_group.keycloak_rg.location
  resource_group_name = azurerm_resource_group.keycloak_rg.name
  allocation_method   = "Dynamic"
  domain_name_label = "keycloak-hylastix"
}


# Create Network Security Group and rule
resource "azurerm_network_security_group" "keycloak_terraform_nsg" {
  name                = "Keycloak_Network_Security_Group"
  location            = azurerm_resource_group.keycloak_rg.location
  resource_group_name = azurerm_resource_group.keycloak_rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "Keycloak_HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "Keycloak_HTTPS"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "Apache_HTTP"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "180"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
    security_rule {
    name                       = "Apache_HTTPS"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

# Create network interface
resource "azurerm_network_interface" "keycloak_NIC" {
  name                = "Keycloak_NIC"
  location            = azurerm_resource_group.keycloak_rg.location
  resource_group_name = azurerm_resource_group.keycloak_rg.name

  ip_configuration {
    name                          = "Keycloak_NIC_configuration"
    subnet_id                     = azurerm_subnet.keycloak_terraform_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.keycloak_public_ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "keycloak_terraform_NIC_nsg" {
  network_interface_id      = azurerm_network_interface.keycloak_NIC.id
  network_security_group_id = azurerm_network_security_group.keycloak_terraform_nsg.id
}



# Generate random text for a unique storage account name
resource "random_id" "random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.keycloak_rg.name
  }

  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "diagnostics_storage_account" {
  name                     = "diag${random_id.random_id.hex}"
  location                 = azurerm_resource_group.keycloak_rg.location
  resource_group_name      = azurerm_resource_group.keycloak_rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "keycloak_terraform_vm" {
  name                  = "Keycloak_VM"
  location              = azurerm_resource_group.keycloak_rg.location
  resource_group_name   = azurerm_resource_group.keycloak_rg.name
  network_interface_ids = [azurerm_network_interface.keycloak_NIC.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "Keycloak_Disk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  # source_image_reference {
  #   publisher = "Debian"
  #   offer     = "debian-12"
  #   sku       = "12"
  #   version   = "0.20230531.1397"
  # }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "cvm"
    version   = "24.04.202411030"
  }  

  computer_name  = "keycloak"
  admin_username = var.username


   admin_ssh_key {
     username   = var.username
     public_key = azurerm_ssh_public_key.keycloak.public_key
   }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.diagnostics_storage_account.primary_blob_endpoint
  }

  custom_data = filebase64("user_data.sh")

}

