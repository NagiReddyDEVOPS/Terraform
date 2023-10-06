# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "MyVpc"
  }
}

# Create a public subnent
resource "aws_subnet" "pbs" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-sub"
  }
}

# Create a private subnent
resource "aws_subnet" "prs" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "prv-sub"
  }
}

# Create a Elastic IP 
resource "aws_eip" "eipv4" {
  vpc      = true
}

# create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "internet_gateway"
  }
}

# create Natgateway 
resource "aws_nat_gateway" "ngtw" {
  allocation_id = aws_eip.eipv4.id
  subnet_id     = aws_subnet.pbs.id

  tags = {
    name = "nategatway"
  }
  depends_on = [aws_eip.eipv4]
}

# create public routing table 
resource "aws_route_table" "pbrt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route"
  }
}

# create private routing table 
resource "aws_route_table" "pvrt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngtw.id
  }

  tags = {
    Name = "private-route"
  }
}

# create public server
resource "aws_instance" "pubser" {
  ami           = "ami-0574da719dca65348"
  instance_type = "t2.micro"
  subnet_id     = "subnet-055bb2617c952b7f5"
  key_name      = aws_key_pair.key.id

  tags = {
    Name = "public_server"
  }
}

# create private server
resource "aws_instance" "prvser" {
  ami           = "ami-0574da719dca65348"
  instance_type = "t2.micro"
  subnet_id     = "subnet-09566d141b5a9418e"
  key_name      = aws_key_pair.key.id

  tags = {
    Name = "private_server"
  }
}

#create key pair 
resource "aws_key_pair" "key" {
  key_name   = "terraform"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDl4P921gh3vSq737eKCysxCfGUEwhSlcFMzUJOwzs7yxqv3xrT2ZxSszoQw6T77+jsqHK2FiEvSeVrcPFOIjWq54SRti09u2NOIpEt0e3sQPnFj0rt324ldkDEFY2awO1noVqv09hcDNJkp1dZt3akoiMG0H8qSoFmlG463a9gelpH0jOqCxWNAerwkTjbXM2GojpT6y1Xh6FiaMlPrz/uiVR8Hhaax6OHIiJamzMPVrJYtVg0SI4LWDgLZAiVzZ0lfrRjkoFUSn8xz04A9AcnNlDHPYtcPEu5qsPdha7/nosm4qHqhFdzfpyEKWdhAQv+P6EtEArQj1GJAxhxCWqERDETdCWchTqTB4BPc68glwOJ2LqE4g/sTmH2jNTjI3vdb4s83G2dsfSDg+yggx844B5p18LQrkEPn2oVFO8cKEf8Ut7ItQNRZD97lSOuqud3WMOkmV606NzfiV/yq7EiqVpb0dSXw1Xyvr6eus3zlFzJb5dae6SdW4vP84xnFDs= lenovo@DESKTOP-SDF3VGH"
}
