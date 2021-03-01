variable "rg" {
    type = string
}

variable "location" {
    type = string
    default = "eastus"
}

variable "servername" {
    type = string
}

variable "subnetid" {
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

variable "vm_image" {
  type = list(object({
    publisher   = string
    offer       = string
    sku         = string
    version     = string
  }))
  default = [
    {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2016-Datacenter"
      version   = "latest"
    }
  ]
}