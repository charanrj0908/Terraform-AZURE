provider "azurerm" {
  version = ">2.0.0"
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "current" {
  name          = "${var.resource_name}-vnet"
  address_space = [var.address_space]
  location      = azurerm_resource_group.rg.location
 resource_group_name = azurerm_resource_group.rg.name
}
   resource "azurerm_subnet" "myterraformsubnet" {
    name                 = "${var.resource_name}-subnet"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.current.name
    address_prefix       = var.address_prefix
}
  resource "azurerm_public_ip" "example" {
  name                = "${var.resource_name}-pblicip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
}


  resource "azurerm_network_security_group" "example" {
  name                = "${var.resource_name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  }
  resource "azurerm_network_interface" "main" {
  name                = "${var.resource_name}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.myterraformsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}
  resource "azurerm_virtual_machine" "main" {
  name                  = "${var.resource_name}-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = var.vm_size

  
  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.sku
    version   = var.image_version
  }
  storage_os_disk {
    name              = "${var.resource_name}osdisk"
    caching           = var.caching
    create_option     = var.create_option
    managed_disk_type = var.storage_account_type
  }
  os_profile {
    computer_name  = "${var.resource_name}host"
    admin_username = "${var.resource_name}admin"
    admin_password = var.pass
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  }
