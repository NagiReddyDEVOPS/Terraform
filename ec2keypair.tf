provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "ec2" {
  ami           = "ami-02a2af70a66af6dfb" # us-west-2
  instance_type = "t2.micro"
  key_name = "testingec2"

tags = {
  Name = "My_Server"
}
}
