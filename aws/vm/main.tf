terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_network_interface" "nic" {
  subnet_id = var.subnet_id
  # private_ips = var.ip_address
  security_groups = [var.security_group_id]

  tags = {
    "Name"        = "${var.name}-NIC"
    "bu"          = "RCTP"
    "environment" = "dev"
  }
}

resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interface {
    network_interface_id = aws_network_interface.nic.id
    device_index         = 0
  }

  tags = {
    "Name"        = var.name
    "bu"          = "RCTP"
    "environment" = "dev"
  }
}
