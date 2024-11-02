resource "aws_vpc" "cluster_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_route_table" "private_cluster_route_table" {
  vpc_id = aws_vpc.cluster_vpc.id
}

resource "aws_route_table" "public_cluster_route_table" {
  vpc_id = aws_vpc.cluster_vpc.id
}

resource "aws_subnet" "public_cluster_subnet_1" {
  vpc_id            = aws_vpc.cluster_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_cluster_subnet_2" {
  vpc_id            = aws_vpc.cluster_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_cluster_subnet_1" {
  vpc_id            = aws_vpc.cluster_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private_cluster_subnet_2" {
  vpc_id            = aws_vpc.cluster_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1c"
}

resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.public_cluster_subnet_1.id
  route_table_id = aws_route_table.public_cluster_route_table.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.public_cluster_subnet_2.id
  route_table_id = aws_route_table.public_cluster_route_table.id
}

resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.private_cluster_subnet_1.id
  route_table_id = aws_route_table.private_cluster_route_table.id
}

resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.private_cluster_subnet_2.id
  route_table_id = aws_route_table.private_cluster_route_table.id
}

