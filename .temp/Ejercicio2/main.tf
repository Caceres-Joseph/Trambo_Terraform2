
provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
}

resource "aws_instance" "example" {
  ami = "ami-0b37e9efc396e4c38"
  instance_type ="t2.micro"
}



