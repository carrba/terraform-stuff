# create resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = var.environment
    source      = "terraform"
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                   = var.aks_name
  local_account_disabled = var.location
  resource_group_name    = var.resource_group_name
  location               = var.location
  dns_prefix             = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = var.environment
    source      = "terraform"
  }
}
