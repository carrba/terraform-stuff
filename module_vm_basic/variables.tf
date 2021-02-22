variable "resource_group_name" {
    type = string
}

variable "location" {
    type = string
    default = "eastus"
}

# terraform-azure-vm module variables
variable "servername" {
    type = string
}