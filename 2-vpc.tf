# VPC SETUP
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_range
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    "Name" = var.vpc_name
  }
}


#Internet Gateway for vpc
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "${var.vpc_name}-igw"
  }
}

#Private Subnet 1 Creation 
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_sb_1
  availability_zone = var.az_1


  tags = {
    "Name"                                      = "${var.vpc_name}-private_subnet-${var.az_1}"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}
#Private Subnet 2 Creation 
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_sb_2
  availability_zone = var.az_2


  tags = {
    "Name"                                      = "${var.vpc_name}-private_subnet-${var.az_2}"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

# Public subnet 1 creation 
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_sb_1
  availability_zone       = var.az_1
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "${var.vpc_name}-public_subnet-${var.az_1}"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}
# Public subnet 2 creation 
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_sb_2
  availability_zone       = var.az_2
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "${var.vpc_name}-public_subnet-${var.az_2}"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

# NAT Gateway Creation 
resource "aws_eip" "nat" {
  tags = {
    "Name" = "${var.vpc_name}-nat"
  }

}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    "Name" = "${var.vpc_name}-nat"
  }
  depends_on = [aws_internet_gateway.igw]
}


# Priavate and Public Route Tables

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id

  }
  tags = {
    "Name" = "${var.vpc_name}-Private_Route_Table"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
  tags = {
    "Name" = "${var.vpc_name}-Public_Route_Table"
  }
}


# Route Table Association 

resource "aws_route_table_association" "private_association_1" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private_subnet_1.id
}
resource "aws_route_table_association" "private_association_2" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private_subnet_2.id
}
resource "aws_route_table_association" "public_association_1" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_subnet_1.id
}
resource "aws_route_table_association" "public_association_2" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_subnet_2.id
}

