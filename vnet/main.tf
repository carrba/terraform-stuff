# azure provider
provider "azure" {
  features {}
}

# create resource group
resource "azurerm_resource_group" "rg" {
  name     = var.rg
  location = var.location
}

module "terraform-azure-vnet" {
  source       = "../modules/terraform-azure-vnet"
  rg           = azurerm_resource_group.rg.name
  location     = azurerm_resource_group.rg.location
  vnet         = var.vnet
  vnet_address = var.vnet_address
  snet         = var.snet
  snet_address = var.snet_address
}
