# create resource group
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

module "sql-server" {
  source   = "dfar-io/sql-server/azurerm"
  version  = "2.1.4"
  location = var.location
  rg_name  = var.rg_name
  name     = var.name
}