
output "public_subnet_ids" {
  type    = "list"
  value = ["${aws_subnet.public.*.id}"]
}

output "private_subnet_ids" {
  type    = "list"
  value = ["${aws_subnet.private.*.id}"]
}


output "availability_zones" {
  type    = "list"
  value = ["${var.availability_zones}"]
}