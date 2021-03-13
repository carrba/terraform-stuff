# terraform
terraform {
  required_providers {
    azure = {
      source  = "hashicorp/azurerm"
      version = "=2.50.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "RG-terraformstate"
    storage_account_name = "itbcvsterraformstorage"
    container_name       = "terraformdemo"
    key                  = "compute.terraform.tfstate"
  }
}

# azure provider
provider "azure" {
  features {}
}