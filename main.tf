#This data source fetches all AWS availability zones and stores them to available variable
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.74"
    }
  }
}
provider "aws" {
    
    access_key =  "AKIA2SYU6AJGDNCTYWFC"
    secret_key  = "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" 
    region = "us-east-1"
}
data "aws_availability_zones" "available" {}
resource "aws_key_pair" "mykey" {



  key_name   = "mykey"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}
resource "aws_instance" "public-webserver1" {
  ami           = "ami-090fa75af13c156b4"
  instance_type = "t2.micro"
  # The number of availability zones depends on region
  availability_zone = data.aws_availability_zones.available.names[0]
  key_name = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.customsecuritygroupssh.id ,aws_security_group.customsecuritygrouphttp.id]
  subnet_id = aws_subnet.customvpc-public1.id
  tags = {
    Name = "public-webserver1"
  }
}

resource "aws_instance" "public-webserver2" {
  ami           = "ami-090fa75af13c156b4"
  instance_type = "t2.micro"
  # The number of availability zones depends on region
  availability_zone = data.aws_availability_zones.available.names[1]
  key_name = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.customsecuritygroupssh.id ,aws_security_group.customsecuritygrouphttp.id]
  subnet_id = aws_subnet.customvpc-public2.id
  tags = {
    Name = "public-webserver2"
  }
}


