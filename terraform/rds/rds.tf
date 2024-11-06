resource "aws_rds_cluster" "postgresql" {
  count                     = 1
  cluster_identifier        = "techchalenge-rds-cluster"
  engine                    = "mysql"
  db_cluster_instance_class = "db.t3.micro"
  database_name             = "techchalenge-rds-database"
  master_username           = "master"
  master_password           = "0dG3y77£"
  vpc_security_group_ids    = data.terraform_remote_state.networking.outputs.aws_security_group.allow_tls.id
}