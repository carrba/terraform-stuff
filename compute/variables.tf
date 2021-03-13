variable "rg_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  type    = string
  default = "eastus"
}

# compute module
variable "admin_username" {
  type        = string
  description = "Admin username for vm"
}

variable "admin_password" {
  type        = string
  description = "Admin password for vm"
  sensitive   = true
}

variable "remote_port" {
  type        = number
  description = "Allowed port in NSG"
  default     = 22
}

variable "remote_ip" {
  type        = string
  description = "Allowed remote IP in NSG"
}