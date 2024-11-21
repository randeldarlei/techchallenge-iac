resource "aws_rds_cluster" "postgresql" {
  cluster_identifier        = "techchalenge"
  db_cluster_instance_class = "t3.micro"
  deletion_protection       = false
  engine                    = "aurora-postgresql"
  database_name             = "techchalenge"
  master_username           = "master"
  master_password           = "0dG3y771"
  vpc_security_group_ids    = [data.terraform_remote_state.network.outputs.aws_security_group_id]
  skip_final_snapshot       = true

  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}