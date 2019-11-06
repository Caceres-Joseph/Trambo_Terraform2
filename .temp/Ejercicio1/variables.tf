variable "name" {
  default = "Default"
}

variable "project" {
  default = "Terraform"
}

variable "environment" {
  default = "Development"
}

variable "region" {
  default = "us-east-1"
}

variable "key_name" {}

variable "cidr_block" {
  default = "10.0.0.0/24"
}

variable "private_subnet_cidr_blocks" {
  type    = "list"
  default = ["10.0.0.0/27", "10.0.0.32/27", "10.0.0.64/27"]
}

variable "public_subnet_cidr_blocks" {
  type    = "list"
  default = ["10.0.0.96/27", "10.0.0.128/27", "10.0.0.160/27"]
}

variable "availability_zones" {
  type    = "list"
  default = ["us-east-1a", "us-east-1b"]
}

variable "bastion_ami" {}

variable "bastion_ebs_optimized" {
  default = false
}

variable "bastion_instance_type" {
  default = "t2.micro"
}
