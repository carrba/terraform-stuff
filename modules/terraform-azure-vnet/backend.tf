terraform {
  required_providers {
    azure = {
      source  = "hashicorp/azurerm"
      version = "=2.84.0"
    }
  }
}

# azure provider
provider "azure" {
  features {}
}