# terraform
terraform {
  required_providers {
    azure = {
      source  = "hashicorp/azurerm"
      version = "=2.73.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "RG-terraformstate"
    storage_account_name = "itbcterraformstorage"
    container_name       = "terraformdemo"
    key                  = "k8.terraform.tfstate"
  }
}

# azure provider
provider "azure" {
  features {}
}