#Adding provider
provider "aws" {
  region = "ap-south-1"
}

# Creating VPC
resource "aws_vpc" "mvpc" {
  cidr_block = "10.0.0.0/16"

    tags = {
    Name = "mytvpc"
  }
}

# Create Public subnet
resource "aws_subnet" "mpbs" {
  vpc_id     = aws_vpc.mvpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "mypubsub"
  }
}

# Create Private subnet 
resource "aws_subnet" "mprvs" {
  vpc_id     = aws_vpc.mvpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "myprvsub"
  }
}

# Create Elastic IP
resource "aws_eip" "eipv4" {
  vpc      = true
  tags = {
    Name = "myelastic_ip"
  }
}

# Create Internet Gate Way
resource "aws_internet_gateway" "migw" {
  vpc_id = aws_vpc.mvpc.id

  tags = {
    Name = "internet_gate_way"
  }
}

# Create Nat-Gate_way 
resource "aws_nat_gateway" "angw" {
  allocation_id = aws_eip.eipv4.id
  subnet_id     = aws_subnet.mpbs.id

  tags = {
    Name = "NAT-GW"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_eip.eipv4]
}

# Create Public route 
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.mvpc.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.migw.id
  }
  tags = {
    Name = "public_route"
  }
}

# Create Private route
resource "aws_route_table" "prv_rt" {
  vpc_id = aws_vpc.mvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.angw.id
  }
  tags = {
    Name = "private_route"
  }
}

# Ass Public subnet and Public route table 
resource "aws_route_table_association" "pub_rt_ass" {
  subnet_id      = aws_subnet.mpbs.id
  route_table_id = aws_route_table.pub_rt.id
}

# Ass Private subnet and Private route table 
resource "aws_route_table_association" "pvr_rt_ass" {
  subnet_id      = aws_subnet.mprvs.id
  route_table_id = aws_route_table.prv_rt.id
}

# Create a public server in public subnet
resource "aws_instance" "ser_p" {
  ami           = "ami-05552d2dcf89c9b24"
  instance_type = "t2.micro"
  subnet_id     = "subnet-08fb07e1b6bd05941" 
  count         = 4
  key_name = "myterraform"

  tags = {
    Name = "Terraform_Server${count.index+1}"
  }
}

# Create a private server in private subnet
resource "aws_instance" "ser_prv" {
  ami           = "ami-05552d2dcf89c9b24"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0f3f12f2e625eebdd" 
  count         = 2
  key_name = "myterraform"

  tags = {
    Name = "Terraform_Prv_Server${count.index+1}"
  }
}

