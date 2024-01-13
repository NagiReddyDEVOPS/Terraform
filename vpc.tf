provider "aws" {
  region = "ap-south-1"
  #  access_key = "AKIAULSASEZG57WVLV7F"
  #  secret_key = "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"
}

resource "aws_vpc" "vtech" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "myvpc"
  }
}

resource "aws_subnet" "pub-sub" {
  vpc_id     = aws_vpc.vtech.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "publicsubnet"
  }
}

resource "aws_subnet" "prvt-sub" {
  vpc_id     = aws_vpc.vtech.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "privatesubnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vtech.id

  tags = {
    Name = "internetgateway"
  }
}

resource "aws_eip" "eip" {
  domain = "vpc"
}


resource "aws_nat_gateway" "mynat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pub-sub.id

  tags = {
    Name = "NATGateWay"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  # depends_on = [aws_internet_gateway.example]
}

resource "aws_route_table" "pub-rot" {
  vpc_id = aws_vpc.vtech.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_routing"
  }
}

resource "aws_route_table" "prt-rot" {
  vpc_id = aws_vpc.vtech.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mynat.id
  }

  tags = {
    Name = "private_routing"
  }
}

resource "aws_instance" "pubserver" {
  ami           = "ami-02a2af70a66af6dfb"
  instance_type = "t2.micro"
  subnet_id  = "subnet-083d906e44aabc8aa"

  tags = {
    Name = "terra-Pub-server123"
  }
}

resource "aws_instance" "prvserver" {
  ami           = "ami-02a2af70a66af6dfb"
  instance_type = "t2.micro"
  subnet_id  = "subnet-0230e2e7d8bd2e4ff"

  tags = {
    Name = "terra-Prv-server123"
  }
}