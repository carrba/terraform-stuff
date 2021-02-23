# resource group variables
variable "rg" {
    type = string
}

variable "location" {
    type = string
    default = "eastus"
}

# vnet variables
variable "vnet" {
    description = "vnet name"
    type = string
    default = "vnet1"
}

variable "vnet_address" {
    description = "vnet address space"
    type = list(string)
    default = [ "10.0.0.0/16" ]
}

# subnet variables
variable "snet" {
    description = "subnet name"
    type = list(string)
    default = [ "subnet1" ]
}

variable "snet_address" {
    description = "subnet address prefixes"
    type = list(string)
    default = [ "10.0.1.0/24" ]
}
