provider "aws" {
  access_key = "AKIA6IB3MVKDYYWZ7R5Y"
  secret_key = "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"
  region = "ap-south-1"
}

resource "aws_instance" "web" {
  ami           = "ami-05552d2dcf89c9b24"
  instance_type = "t2.micro"
  key_name = "myterraform"

  tags = {
    Name = "Terraform_Server"
  }
}

terraform {
  backend "s3" {
    bucket = "mybucket-vtech-12"
    key    = "C:\\Users\\lenovo\\Desktop\\abc\\terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "mydynamo-vtech-12"
  }
}
