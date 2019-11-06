
  #-------------
  # Project

variable "project" {
  default = "Terraform_Joseph"
}

variable "environment" {
  default = "Development"
}

variable "region" {
  default = "us-west-2"
}

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



//Security group

resource "aws_security_group" "default" {
vpc_id = "${aws_vpc.myvpc.id}"

  # ... snip ...
  # security group rules can go here
}
variable "http_ports" {
  default = ["80", "443", "8080", "8443"]
}
resource "aws_security_group_rule" "ingress" {
  count = "${length(var.http_ports)}"

  type        = "ingress"
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = "${element(var.http_ports, count.index)}"
  to_port     = "${element(var.http_ports, count.index)}"

  security_group_id = "${aws_security_group.default.id}"
}


resource "aws_security_group_rule" "egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.default.id}"
}

resource "aws_security_group_rule" "ssh_from_me" {
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  cidr_blocks     = ["${chomp(data.http.my_local_ip.body)}/32"]

  security_group_id = "${aws_default_security_group.default.id}"
}
