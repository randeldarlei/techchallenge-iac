resource "aws_vpc" "cluster_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Cluster VPC"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.cluster_vpc.id
  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "public_cluster_route_table" {
  vpc_id = aws_vpc.cluster_vpc.id
  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_subnet" "public_cluster_subnet_1" {
  vpc_id                   = aws_vpc.cluster_vpc.id
  cidr_block               = "10.0.1.0/24"
  availability_zone        = "us-east-1a"
  map_public_ip_on_launch  = true
  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "public_cluster_subnet_2" {
  vpc_id                   = aws_vpc.cluster_vpc.id
  cidr_block               = "10.0.2.0/24"
  availability_zone        = "us-east-1b"
  map_public_ip_on_launch  = true
  tags = {
    Name = "Public Subnet 2"
  }
}

resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.public_cluster_subnet_1.id
  route_table_id = aws_route_table.public_cluster_route_table.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.public_cluster_subnet_2.id
  route_table_id = aws_route_table.public_cluster_route_table.id
}

resource "aws_route" "public_to_internet" {
  route_table_id         = aws_route_table.public_cluster_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}
