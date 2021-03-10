variable "rg" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "servername" {
  type = string
}

variable "subnetid" {
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
  description = "os image sku"
  default     = "latest"
}