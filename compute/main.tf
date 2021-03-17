# create resource group
resource "azurerm_resource_group" "example" {
  name     = var.rg_name
  location = var.location
}

data "template_file" "init" {
  template = file("${path.module}/cloud-init.txt")
  # vars = {
  #   webservername = var.servername
  # }
}

module "linuxservers" {
  source                  = "Azure/compute/azurerm"
  resource_group_name     = azurerm_resource_group.example.name
  vm_os_simple            = "UbuntuServer"
  public_ip_dns           = ["linuxvm1-itbc"] // change to a unique name per datacenter region
  vnet_subnet_id          = module.network.vnet_subnets[0]
  vm_hostname             = var.vm_hostname
  admin_username          = var.admin_username
  admin_password          = var.admin_password
  remote_port             = var.remote_port
  source_address_prefixes = var.source_address_prefixes
  custom_data             = base64encode(data.template_file.init.rendered)
  nb_instances            = 1

  depends_on = [azurerm_resource_group.example]
}

module "windowsservers" {
  source              = "Azure/compute/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  is_windows_image    = true
  vm_hostname         = "mywinvm" // line can be removed if only one VM module per resource group
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  vm_os_simple        = "WindowsServer"
  public_ip_dns       = ["winvm1-itbc"] // change to a unique name per datacenter region
  vnet_subnet_id      = module.network.vnet_subnets[0]
  nb_instances        = 0

  depends_on = [azurerm_resource_group.example]
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = ["subnet1"]

  depends_on = [azurerm_resource_group.example]
}

output "linux_vm_public_name" {
  value = module.linuxservers.public_ip_dns_name
}
