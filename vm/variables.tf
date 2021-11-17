variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus"
}

# terraform-azure-vnet module variables
variable "vnet" {
  description = "vnet name"
  type        = string
}

variable "vnet_address" {
  description = "vnet address space"
  type        = list(string)
}

# subnet variables
variable "snet" {
  description = "subnet name"
  type        = list(string)
}

variable "snet_address" {
  description = "subnet address prefixes"
  type        = list(string)
}


# terraform-azure-vm module variables
variable "servername" {
  type = string
}

variable "username" {
  type        = string
  description = "vm username"
}

variable "password" {
  type        = string
  description = "vm user password"
  sensitive   = true
}

variable "vm_size" {
  type        = string
  description = "vm size"
  default     = "Standard_B1s"
}

variable "publisher" {
  type        = string
  description = "os image publisher"
}

variable "offer" {
  type        = string
  description = "os image offer"
}

variable "sku" {
  type        = string
  description = "os image sku"
}

variable "image_version" {
  type        = string
  description = "os image version"
  default     = "latest"
}

variable "environment" {
  type = string
  description = "Environment tag"
  default = "dev"
}

variable "Application" {
  type = string
  description = "Application name"
}

variable "nsg_name" {
  type = string
  description = "NSG name"
}

variable "source_ip" {
  type = list(string)
  description = "List of source IPs for NSG rule" 
}