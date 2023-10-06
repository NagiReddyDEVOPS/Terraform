provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAZL2B5IFT3RP7VSEL"
  secret_key = "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"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf-vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"

  tags = {
    Name = "tf-pb-subnet"
  }
}

resource "aws_subnet" "my_subnet-pv" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.9.0/24"

  tags = {
    Name = "tf-pv-subnet"
  }
}


resource "aws_instance" "pbserver" {
  ami           = "ami-0574da719dca65348"
  instance_type = "t2.micro"
  subnet_id  = "subnet-0e6138836b7a702f3"

  tags = {
    Name = "terra-server"
  }
}
