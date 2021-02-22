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
      key                   = "module_vm_basic.terraform.tfstate"
    }
}

# azure provider
provider "azure" {
    features {}
}

# create resource group
resource "azurerm_resource_group" "rg" {
    name = var.resource_group_name
    location = var.location
}

module "terraform-azure-vnet" {
    source = "./modules/terraform-azure-vnet"
    rg = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    # rg = var.resource_group_name
    # location = var.location
}

module "terraform-azure-vm" {
    source = "./modules/terraform-azure-vm"
    rg = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location

    servername = var.servername
}
