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
terraform {
  backend "s3" {
    bucket         = "lock-terraform-test"
    key            = "C:\\Users\\lenovo\\Desktop\\Nag\\terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "lock-terraform-dyanamodb-test"
  }
}