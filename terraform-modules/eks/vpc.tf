resource "aws_vpc" "cluster_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_route_table" "private_cluster_route_table" {
  vpc_id = aws_vpc.cluster_vpc.id
}

resource "aws_route_table" "public_cluster_route_table" {
  vpc_id = aws_vpc.cluster_vpc.id
}

resource "aws_subnet" "public_cluster_subnet" {
  vpc_id            = aws_vpc.cluster_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = false
}

resource "aws_subnet" "private_cluster_subnet" {
  vpc_id            = aws_vpc.cluster_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_cluster_subnet.id
  route_table_id = aws_route_table.public_cluster_route_table.id
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_cluster_subnet.id
  route_table_id = aws_route_table.private_cluster_route_table.id
}
