resource "aws_security_group" "enum_V2_Elb_sg" {
  name        = "enum_V2_Elb_sg"
  description = "Allow TLS inbound traffic from enum web application"
  vpc_id      = aws_vpc.enum_vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.enum_vpc.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "enum_V2_Elb_SG"
  }
}

resource "aws_security_group" "enum_V2_app_sg" {
  name        = "enum_V2_app_sg"
  description = "Allow TLS inbound traffic from enum web application to the elastic loadbalancer"
  vpc_id      = aws_vpc.enum_vpc.id

  ingress {
    description      = "Allows the application to connect to the ELB"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = [aws_security_group.enum_V2_Elb_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "enum_V2_APP_SG"
  }
}

resource "aws_security_group" "enum_V2_backend_sg" {
  name        = "enum_V2_backend_sg"
  description = "Allow TLS inbound traffic from enum web application to the elastic loadbalancer"
  vpc_id      = aws_vpc.enum_vpc.id

  ingress {
    description      = "Allow the application to connect to the postgress db"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    security_groups = [aws_security_group.enum_V2_app_sg.id]
  }
  ingress {
    description      = "Allow the application to connect to the memcache"
    from_port        = 11211
    to_port          = 11211
    protocol         = "tcp"
    security_groups = [aws_security_group.enum_V2_app_sg.id]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "enum_V2_BACKEND_SG"
  }
}