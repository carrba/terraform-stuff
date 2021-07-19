variable "vm_name" {
  description = "EC2 instance_name"
  type        = string
}

variable "region" {
  description = "Default region"
  type        = string
  default     = "eu_west-1"
}

variable "ami" {
  description = "ami image"
  type        = string
  default     = "ami-0acec5a529be6b35a"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "sg" {
  description = "Security group"
  type        = string
}

variable "key_name" {
  description = "Key name for EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "hosted_zone_name" {
  description = "Hosted zone name of the desired DNS hosted zone"
  default     = "myDNSzone"
}