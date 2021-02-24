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
      key                   = "KeyVault.terraform.tfstate"
    }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

data "azurerm_client_config" "current" {}

# create resource group
resource "azurerm_resource_group" "rg" {
    name = var.rg
    location = var.location
}

resource "azurerm_key_vault" "kv" {
  name                        = "examplekeyvault"
  location                    = var.location
  resource_group_name         = var.rg
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}