provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "web" {
  ami           = "ami-05552d2dcf89c9b24"
  instance_type = "t2.micro"
  key_name = "myterraform"

  tags = {
    Name = "Terraform_Server_out_put"
  }
}
output "instance_ip_addr" {
  value = aws_instance.web.public_ip
}
