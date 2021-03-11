# azure provider
provider "azure" {
  features {}
}

# create resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-t6"
  location = "uksouth"
}

# create vnet
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-dev-uksouth-001"
  address_space       = ["10.0.0.0/16", "10.1.0.0/16"]
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

# create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "snet-dev-uksouth-001t"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# create vm nic
resource "azurerm_network_interface" "vm1-nic" {
  name                = "vm1-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "vm1-ip-conf"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm1" {
  name                  = "vm1"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.vm1-nic.id]
  vm_size               = "Standard_B1s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "vm1"
    admin_username = "carrb"
    admin_password = "FGe3sX-jhsafd-ll£ds"
  }
  os_profile_windows_config {
  }
  tags = {
    environment = "staging"
  }
}
