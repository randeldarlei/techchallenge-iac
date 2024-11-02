resource "aws_rds_cluster" "postgresql" {
  count                     = 1
  cluster_identifier        = "techchalenge-rds-cluster"
  engine                    = "mysql"
  availability_zones        = ["us-east-1a", "us-east-1b", "us-east-1c"]
  db_cluster_instance_class = "db.t3.micro"
  database_name             = "techchalenge-rds-database"
  master_username           = "master"
  master_password           = "0dG3y77£"
}