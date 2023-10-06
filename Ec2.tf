provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAZL2B5IFT3RP7VSEL"
  secret_key = "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"
}

resource "aws_instance" "ec2" {
  ami           = "ami-090e0fc566929d98b"
  instance_type = "t2.micro"
}