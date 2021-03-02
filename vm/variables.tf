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

variable "username" {
    type = string
    description = "vm username"
}

variable "password" {
    type = string
    description = "vm user password"
    sensitive = true
}

variable "vm_size" {
    type = string
    description = "vm size"
    default = "Standard_B1s"
}

variable "vm_image" {
  type = map
  default = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2016-Datacenter"
      image_version   = "latest"
  }
}
