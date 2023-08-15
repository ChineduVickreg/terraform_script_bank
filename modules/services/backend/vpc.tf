resource "aws_vpc" "enum_vpc" {
  cidr_block = "10.0.0.0/16"  # Change this CIDR block to your desired VPC IP range
  tags = {
    Name = "EnumVPC"
  }
}


resource "aws_subnet" "enum_Public_Subnets_1" {
  vpc_id                  = aws_vpc.enum_vpc.id
  cidr_block              = "10.0.1.0/26"  # Change this CIDR block to your desired subnet IP range
  availability_zone       = "us-east-1a"  # Change this to your desired AWS availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet"

  }
}
resource "aws_subnet" "enum_Private_Subnets_1" {
  vpc_id                  = aws_vpc.enum_vpc.id
  cidr_block              = "10.0.2.0/26"  # Change this CIDR block to your desired subnet IP range
  availability_zone       = "us-east-1a"  # Change this to your desired AWS availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "PrivateSubnet"

  }
}

resource "aws_subnet" "enum_Public_Subnets_2" {
  vpc_id                  = aws_vpc.enum_vpc.id
  cidr_block              = "10.0.3.0/24"  # Change this CIDR block to your desired subnet IP range
  availability_zone       = "us-east-1b"  # Change this to your desired AWS availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet"

  }
}
resource "aws_subnet" "enum_Private_Subnets_2" {
  vpc_id                  = aws_vpc.enum_vpc.id
  cidr_block              = "10.0.4.0/24"  # Change this CIDR block to your desired subnet IP range
  availability_zone       = "us-east-1b"  # Change this to your desired AWS availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "PrivateSubnet"

  }
}



resource "aws_internet_gateway" "enum-gw" {
  vpc_id = aws_vpc.enum_vpc.id
  
  tags = {
    Name = "EnumGateway"
  }
}

resource "aws_route_table" "enum-Public_Route-table" {
  vpc_id = aws_vpc.enum_vpc.id
route {
    cidr_block = "0.0.0.0/0"  # Route all traffic to the Internet Gateway
    gateway_id = aws_internet_gateway.enum-gw.id
  }

  tags = {
    Name = "Enum-Public-rt"
  }
}

resource "aws_route_table" "enum-Private_Route-table" {
  vpc_id = aws_vpc.enum_vpc.id

  tags = {
    Name = "Enum-Private-rt"
  }
}
resource "aws_route_table_association" "Public_rta" {
  subnet_id = aws_subnet.enum_Public_Subnets_1.id
  route_table_id   = aws_route_table.enum-Public_Route-table.id
}

resource "aws_route_table_association" "Private_rta" {
  subnet_id = aws_subnet.enum_Private_Subnets_2.id
  route_table_id   = aws_route_table.enum-Private_Route-table.id
  
}

