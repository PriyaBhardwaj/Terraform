# AWS elb configuration

resource "aws_elb" "custom-elb" {
  name               = "custom-elb"
  subnets = [aws_subnet.customvpc-public1.id,aws_subnet.customvpc-public2.id]
  security_groups = [aws_security_group.custom-elb-sg.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = [aws_instance.public-webserver1.id,aws_instance.public-webserver2.id]
  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "custom-elb"
  }
}
# security group for elb


resource "aws_security_group" "custom-elb-sg" {
  name        = "customsecuritygroupelb"
  description = "This is the security group for Load balancer."
  vpc_id      = aws_vpc.customvpc.id

  ingress {
    description      = "TLS from VPC"
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
    Name = "custom-elb-sg"
  }
}

