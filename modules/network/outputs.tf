
output "public_subnet_ids" { 
  value = "${aws_subnet.public}"
}

output "private_subnet_ids" { 
  value = ["${aws_subnet.private.*.id}"]
}


output "availability_zones" { 
  value = ["${var.availability_zones}"]
}