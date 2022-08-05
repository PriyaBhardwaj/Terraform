# Create AWS VPC

resource "aws_vpc" "customvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  
  tags = {
    Name = "customVPC"
  }
}

# Create Subnets in the custom VPC
resource "aws_subnet"  "customvpc-public1" {
  vpc_id     = aws_vpc.customvpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "customvpc-public1"
  }
}

resource "aws_subnet" "customvpc-public2" {
  vpc_id     = aws_vpc.customvpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"

  tags = {
    Name = "customvpc-public2"
  }
}

# Define the Internet Gateway
resource "aws_internet_gateway" "customvpc-igw" {
  vpc_id = aws_vpc.customvpc.id

  tags = {
    Name = "customvpc-igw"
  }
}

# Define routing table for the custom VPC

resource "aws_route_table" "customvpc-route-public" {
  vpc_id = aws_vpc.customvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.customvpc-igw.id
  }

  tags = {
    Name = "customvpc-route-public"
  }
}

# route association public

resource "aws_route_table_association" "customvpc-public1-ra" {
  subnet_id      = aws_subnet.customvpc-public1.id
  route_table_id = aws_route_table.customvpc-route-public.id
}


resource "aws_route_table_association" "customvpc-public2-ra" {
  subnet_id      = aws_subnet.customvpc-public2.id
  route_table_id = aws_route_table.customvpc-route-public.id
}
