# create resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
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

module "terraform-azure-vm" {
  source        = "../modules/terraform-azure-vm"
  rg            = azurerm_resource_group.rg.name
  location      = azurerm_resource_group.rg.location
  servername    = var.servername
  subnetid      = module.terraform-azure-vnet.subnetid
  vm_size       = var.vm_size
  username      = var.username
  password      = var.password
  publisher     = var.publisher
  sku           = var.sku
  offer         = var.offer
  image_version = var.image_version
}