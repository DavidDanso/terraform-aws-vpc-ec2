resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main-vpc"
  }
}

# public subnet -1a
resource "aws_subnet" "public_1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[0]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1a"
  }
}

# public subnet -1b
resource "aws_subnet" "public_1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[1]
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1b"
  }
}

# private subnet -1a
resource "aws_subnet" "private_1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidrs[0]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-1a"
  }
}

# private subnet -1b
resource "aws_subnet" "private_1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidrs[1]
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-1b"
  }
}

# internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-main"
  }
}

# route table for public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# route table association for public subnet
resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.public.id
}

# route table association for public subnet
resource "aws_route_table_association" "public_1b" {
  subnet_id      = aws_subnet.public_1b.id
  route_table_id = aws_route_table.public.id
}

