provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "vennan"
  public_key = trimspace(tls_private_key.rsa-4096-example.public_key_openssh)
}

resource "tls_private_key" "rsa-4096-example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private-key" {
  content  = tls_private_key.rsa-4096-example.private_key_pem
  filename = "vennan.pem"
}
resource "aws_instance" "ec2" {
  ami           = "ami-02a2af70a66af6dfb" # us-west-2
  instance_type = "t2.micro"
  key_name = aws_key_pair.deployer.key_name
  count = 4

tags = {
  Name = "My_Server-${count.index+1}"
}
}