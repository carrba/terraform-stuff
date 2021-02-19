# Outputs
output "rg_name" {
    description = "resource group"
    value       = azurerm_resource_group.rg.name
}

output "vnet_name" {
    description = "virtual network"
    value       = azurerm_virtual_network.vnet.name
}