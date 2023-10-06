provider "aws" {
  region     = "ap-south-1"
}

resource "aws_instance" "ec2" {
  ami           = "ami-07a8045d9f6683d4a"
  instance_type = "t2.micro"
  
    tags = {
    Name = "Terra-server123"
  }
}