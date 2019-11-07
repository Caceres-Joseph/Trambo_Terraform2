

  #-------------
  # Security group

resource "aws_security_group" "ingress-all-test" {
  name = "allow-all-sg"
  vpc_id = "${var.id_vpc}"
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  // Terraform removes the default rule
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


  #-------------
  # Public instance
  
resource "aws_instance" "ec2_joseph_public" {
  ami                         = "ami-0b37e9efc396e4c38"
  instance_type               = "t2.micro"
  availability_zone           = "${var.availability_zones[0]}"  
  monitoring                  = true
  subnet_id                   = "${var.public_subnet_ids.*.id[0]}"
  associate_public_ip_address = true
  security_groups = ["${aws_security_group.ingress-all-test.id}"]
  key_name = "joseph-key"

  tags = {
    Name        = "ec2_joseph_public"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}



  #-------------
  # Private instance
  
resource "aws_instance" "ec2_joseph_private" {
  

  ami                         = "ami-0b37e9efc396e4c38"
  instance_type               = "t2.micro"
  availability_zone           = "${var.availability_zones[0]}"  
  monitoring                  = true
  subnet_id                   = "${var.private_subnet_ids.*.id[0]}"
  associate_public_ip_address = false
  security_groups = ["${aws_security_group.ingress-all-test.id}"] 

  tags = {
    Name        = "ec2_joseph_private"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}