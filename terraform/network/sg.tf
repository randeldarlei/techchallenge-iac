resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS, PostgreSQL traffic for EKS, and outbound traffic"
  vpc_id      = aws_vpc.cluster_vpc.id

  tags = {
    Name = "EKS Security Group"
  }
}

# Permite conexões ao RDS a partir da VPC do EKS (10.0.0.0/16)
resource "aws_security_group_rule" "allow_postgres_from_eks" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"] # VPC CIDR Block do EKS
  security_group_id = aws_security_group.allow_tls.id
}

# Permite tráfego HTTP
resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_tls.id
}

# Permite tráfego HTTPS
resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_tls.id
}

# Permite tráfego de saída para a internet
resource "aws_security_group_rule" "allow_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_tls.id
}

# Permite comunicação interna entre recursos na VPC do EKS
resource "aws_security_group_rule" "allow_internal_communication" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_security_group.allow_tls.id
}

resource "aws_security_group_rule" "allow_http_8080" {
  type              = "ingress" # Entrada no backend
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # Permitir de qualquer IP
  security_group_id = aws_security_group.allow_tls.id
}

resource "aws_security_group_rule" "allow_outbound_8080" {
  type              = "egress" # Saída do backend
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # Permitir saída para qualquer IP
  security_group_id = aws_security_group.allow_tls.id
}
