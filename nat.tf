# Define external IP - NAT Gateway- use Nat gateway for EC2 in a private VPC subnet to connect seurely over the internet

resource "aws_eip" "customvpc-nat" {
  vpc      = true
}

resource "aws_nat_gateway" "customvpc-nat-gw" {
  allocation_id = aws_eip.customvpc-nat.id
  subnet_id     = aws_subnet.customvpc-public1.id

  tags = {
    Name = "customvpc-nat-gw"
  }
   # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.customvpc-igw]
}

# Route table for private subnet
resource "aws_route_table" "customvpc-private-rt" {
  vpc_id = aws_vpc.customvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.customvpc-nat-gw.id
  }

  tags = {
    Name = "customvpc-private-rt"
  }
}

# route association private

resource "aws_route_table_association" "customvpc-private1-ra" {
  subnet_id      = aws_subnet.customvpc-private1.id
  route_table_id = aws_route_table.customvpc-private-rt.id
}

