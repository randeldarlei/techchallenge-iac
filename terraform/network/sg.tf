resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS, PostgreSQL traffic for EKS, and outbound traffic"
  vpc_id      = aws_vpc.cluster_vpc.id

  tags = {
    Name = "EKS Security Group"
  }
}

# Permite conexões ao RDS a partir da Internet
resource "aws_security_group_rule" "allow_postgres_from_internet" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["<SEU-IP-PÚBLICO>/32"]
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

# Permite tráfego para o backend (porta 8080)
resource "aws_security_group_rule" "allow_http_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_tls.id
}
