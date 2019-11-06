

  #-------------
  # Instance
  
resource "aws_instance" "ec2_joseph" {
  ami                         = "ami-0b37e9efc396e4c38"
  instance_type               = "t2.micro"
  //availability_zone           = "${var.availability_zones.*.id[0]}"  
  monitoring                  = true
  subnet_id                   = "${var.public_subnet_ids.id[0]}"
  associate_public_ip_address = true

  tags = {
    Name        = "ec2_joseph"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}