# terraform
terraform {
  required_providers {
    azure = {
      source  = "hashicorp/azurerm"
      version = "=2.50.0"
    }
  }
}

# azure provider
provider "azure" {
  features {}
}

# create vm nic
resource "azurerm_network_interface" "vm-nic" {
  name                = "${var.servername}-nic"
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {
    name                          = "${var.servername}-ip-conf"
    subnet_id                     = var.subnetid
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "windows" {
  count                 = var.publisher == "MicrosoftWindowsServer" ? 1 : 0
  name                  = var.servername
  location              = var.location
  resource_group_name   = var.rg
  network_interface_ids = [azurerm_network_interface.vm-nic.id]
  vm_size               = var.vm_size

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.image_version
  }
  storage_os_disk {
    name              = "${var.servername}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.servername
    admin_username = var.username
    admin_password = var.password
  }
  os_profile_windows_config {
  }
  tags = {
    environment = "staging"
  }
}

resource "azurerm_virtual_machine" "linux" {
  count                 = var.publisher == "MicrosoftWindowsServer" ? 0 : 1
  name                  = var.servername
  location              = var.location
  resource_group_name   = var.rg
  network_interface_ids = [azurerm_network_interface.vm-nic.id]
  vm_size               = var.vm_size

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.image_version
  }
  storage_os_disk {
    name              = "${var.servername}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.servername
    admin_username = var.username
    admin_password = var.password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}