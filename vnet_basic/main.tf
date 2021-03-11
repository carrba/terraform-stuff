# create resource group
resource "azurerm_resource_group" "rg" {
  name     = var.rg
  location = var.location
}

# create vnet
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.location}-001"
  address_space       = ["10.0.0.0/16", "10.1.0.0/16"]
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

# create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "snet-${var.location}-001"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}
