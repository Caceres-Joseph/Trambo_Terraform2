
  #-------------
  # Project

variable "project" {}

variable "environment" {}

variable "region" {}



  #-------------
  # VPC

variable "cidr_block" {
  default = "10.0.0.0/24"
}

  #-------------
  # Subnets

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
  default = ["us-west-2a", "us-west-2b" , "us-west-2a"]
}