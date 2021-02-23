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
      storage_account_name  = "itbcvsterraformstorage"
      container_name        = "terraformdemo"
      key                   = "vnet.terraform.tfstate"
    }
}

# azure provider
provider "azure" {
    features {}
}

# create resource group
resource "azurerm_resource_group" "rg" {
    name = var.rg
    location = var.location
}

module "terraform-azure-vnet" {
    source = "../modules/terraform-azure-vnet"
    rg = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    vnet = var.vnet
    vnet_address = var.vnet_address
    snet = var.snet
    snet_address  = var.snet_address 
}
