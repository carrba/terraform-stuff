# create vnet
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet
  address_space       = var.vnet_address
  resource_group_name = var.rg
  location            = var.location
}

# create subnet
resource "azurerm_subnet" "subnet" {
  name                 = var.snet[0]
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.snet_address
}

# NSG
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  resource_group_name = var.rg
  location            = var.location

  security_rule {
    name                       = "HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefixes    = var.source_ip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefixes    = var.source_ip
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment
    Application = var.Application
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-associate" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}