# terraform
terraform {
    required_providers {
        azure = {
            source  = "hashicorp/azurerm"
            version = "=2.40.0"
        }
    }
    backend "azurerm" {
      resource_group_name   = "RG-terraformstate"
      storage_account_name  = "itbcterraformstorage"
      container_name        = "terraformdemo"
      key                   = "dev.terraform.tfstate"
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
    name                          = "vm-ip-conf"
    subnet_id                     = var.subnetid
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = var.servername
  location              = var.location
  resource_group_name   = var.rg
  network_interface_ids = [azurerm_network_interface.vm-nic.id]
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
    computer_name  = var.servername
    admin_username = "carrb"
    admin_password = "FGe3sX-jhsafd-ll£ds"
  }
  os_profile_windows_config {
  }
  tags = {
    environment = "staging"
  }
}