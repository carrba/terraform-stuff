variable "rg_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  type    = string
  default = "eastus"
}

# module variables - sql-server
variable "name" {
  type        = string
  description = "sql server resource name"
}