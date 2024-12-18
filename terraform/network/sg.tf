resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS, PostgreSQL traffic for EKS, and outbound traffic"
  vpc_id      = aws_vpc.cluster_vpc.id

  tags = {
    Name = "EKS Security Group"
  }
}

# Permite conexões ao RDS a partir de qualquer IP (subnets públicas)
resource "aws_security_group_rule" "allow_postgres_from_internet" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # Permite acesso público ao RDS
  security_group_id = aws_security_group.allow_tls.id
}

# Permite tráfego HTTP ao backend
resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # Permite acesso público HTTP
  security_group_id = aws_security_group.allow_tls.id
}

# Permite tráfego HTTPS ao backend
resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # Permite acesso público HTTPS
  security_group_id = aws_security_group.allow_tls.id
}

# Permite tráfego de saída para a internet
resource "aws_security_group_rule" "allow_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"] # Permite saída irrestrita
  security_group_id = aws_security_group.allow_tls.id
}

# Permite tráfego interno entre recursos na VPC (EKS e RDS)
resource "aws_security_group_rule" "allow_internal_communication" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"] # Tráfego interno da VPC
  security_group_id = aws_security_group.allow_tls.id
}

# Permite tráfego HTTP ao backend na porta 8080
resource "aws_security_group_rule" "allow_http_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # Permite acesso público na porta 8080
  security_group_id = aws_security_group.allow_tls.id
}
