
output "public_subnet_ids" { 
  value = "${aws_subnet.public}"
}

output "private_subnet_ids" { 
  value = "${aws_subnet.private}"
}


output "availability_zones" { 
  value = "${var.availability_zones}"
}


output "id_vpc" { 
  value = "${aws_vpc.my_vpc.id}"
}