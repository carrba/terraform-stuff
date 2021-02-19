# create vnet
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-dev-eastus-001"
  address_space       = ["10.0.0.0/16","10.1.0.0/16"]
  resource_group_name = var.rg
  location            = var.location
}

# create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "snet-dev-eastus-001"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}