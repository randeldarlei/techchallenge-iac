# Outputs da VPC e subnets criadas
output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.cluster_vpc.id
}

output "public_subnet_ids" {
  description = "IDs das subnets públicas"
  value       = [
    aws_subnet.public_cluster_subnet_1.id,
    aws_subnet.public_cluster_subnet_2.id
  ]
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas"
  value       = [
    aws_subnet.private_cluster_subnet_1.id,
    aws_subnet.private_cluster_subnet_2.id,
    aws_subnet.private_cluster_subnet_3.id
  ]
}

output "public_route_table_id" {
  description = "ID da tabela de rotas pública"
  value       = aws_route_table.public_cluster_route_table.id
}

output "private_route_table_id" {
  description = "ID da tabela de rotas privada"
  value       = aws_route_table.private_cluster_route_table.id
}

output "aws_security_group_id" {
  description = "ID do Security Group"
  value       = aws_security_group.allow_tls.id
}

output "aws_internet_gateway_id" {
  description = "ID do Internet Gateway"
  value       = aws_internet_gateway.gw.id
}