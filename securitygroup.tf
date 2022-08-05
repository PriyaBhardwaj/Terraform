
resource "aws_security_group" "customsecuritygroupssh" {
  name        = "customsecuritygroupssh"
  description = "This is the security allows ssh connection."
  vpc_id      = aws_vpc.customvpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  tags = {
    Name = "customsecuritygroupssh"
  }
}

resource "aws_security_group" "customsecuritygrouphttp" {
  name        = "customsecuritygroup-http"
  description = "This is the security allows http connection."
  vpc_id      = aws_vpc.customvpc.id

  ingress {

    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "customsecuritygrouphttp"
  }
}