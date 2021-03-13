# create resource group
resource "azurerm_resource_group" "example" {
  name     = var.rg_name
  location = var.location
}

#data "template_file" "init" {
#  template = file("${path.module}/post-deploy.sh")
#  cars = {
#    webservername = var.servername
#  }
#}

module "linuxservers" {
  source              = "Azure/compute/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  vm_os_simple        = "UbuntuServer"
  public_ip_dns       = ["linuxvm1-itbc"] // change to a unique name per datacenter region
  vnet_subnet_id      = module.network.vnet_subnets[0]
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  remote_port         = var.remote_port
  remote_ip           = var.remote_ip
  # custom_data         = base64encode(data.template_file.rendered)
  custom_data = "touch /tmp/xxx1234.txt"
  depends_on  = [azurerm_resource_group.example]
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