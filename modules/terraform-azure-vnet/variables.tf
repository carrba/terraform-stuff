# resource group variables
variable "rg" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus"
}

# vnet variables
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

variable "nsg_name" {
  type = string
  description = "NSG name"
}

variable "source_ip" {
  type = list(string)
  description = "List of source IPs for NSG rule" 
}

variable "environment" {
  type        = string
  description = "Environment tag"
  default     = "dev"
}

variable "Application" {
  type        = string
  description = "Application name"
}