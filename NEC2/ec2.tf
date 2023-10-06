# terraform s3 backend resource
terraform {
  backend "s3" {
    bucket = "vtech-05-07-2023"
    key    = "Statevt/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  ami           = var.ami
  count = 2
  instance_type = var.ins
  subnet_id = "${element(var.sub,count.index)}"
  security_groups = ["sg-0915b65cb95f8d643"]

  tags = {
    Name = "server-vtech${count.index+1}"
    
  }
}




