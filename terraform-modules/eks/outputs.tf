output "vpc_id" {
  value = aws_vpc.cluster_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_cluster_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_cluster_subnet.id
}

output "subnet_ids" {
  value = [
    aws_subnet.public_cluster_subnet.id,
    aws_subnet.private_cluster_subnet.id
  ]
}
