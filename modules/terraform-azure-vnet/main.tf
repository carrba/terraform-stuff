# terraform
terraform {
  required_providers {
    azure = {
      source = "hashicorp/azurerm"
      version = "=2.40.0"
    }
  }
}

# azure provider
provider "azure" {
  features {}
}


# create vnet
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet
  address_space       = var.vnet_address
  resource_group_name = var.rg
  location            = var.location
}

# create subnet
resource "azurerm_subnet" "subnet" {
  name                 = var.snet
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.snet_address
}