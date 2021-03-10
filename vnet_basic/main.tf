# terraform
terraform {
  required_providers {
    azure = {
      source  = "hashicorp/azurerm"
      version = "=2.40.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "RG-terraformstate"
    storage_account_name = "itbcvsterraformstorage"
    container_name       = "terraformdemo"
    key                  = "dev.terraform.tfstate"
  }
}

# azure provider
provider "azure" {
  features {}
}

# create resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-t1"
  location = "eastus"
}

# create vnet
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-dev-eastus-001"
  address_space       = ["10.0.0.0/16", "10.1.0.0/16"]
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

# create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "snet-dev-eastus-001t"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}