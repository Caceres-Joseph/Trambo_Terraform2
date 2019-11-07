



variable "cluster-name" {
  default = "terraform-eks-demo"
  type    = "string"
}



  #-------------
  # Project

variable "project" {}

variable "environment" {}

variable "region" {}


  #-------------
  # VPC id


variable "id_vpc" {}
  #-------------
  # Subnets


variable "public_subnet_ids" {
}
 
variable "private_subnet_ids" {
}
 

  #-------------
  # A. Z.
 
variable "availability_zones" {}
  

