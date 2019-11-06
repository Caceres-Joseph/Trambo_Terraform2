
output "bastion_hostname" {
  value = "${aws_instance.bastion.public_dns}"
}