
  #-------------
  # Project

variable "project" {}

variable "environment" {}

variable "region" {}


  #-------------
  # Subnets


variable "public_subnet_ids" {
  type    = "list"
}
 

  #-------------
  # A. Z.


variable "availability_zones" {
  type    = "list" 
}