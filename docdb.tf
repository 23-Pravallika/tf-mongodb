#creates the cluster
resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "my-docdb-cluster"
  engine                  = "docdb"
  master_username         = "admin1"
  master_password         = "roboshop1"
#   backup_retention_period = 5
#   preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_docdb_subnet_group.docdb_subnet_group.name
}

# Creates Subnet Group Needed to host the docdb cluster 
resource "aws_docdb_subnet_group" "docdb_subnet_group" {
  name       = "robo-${var.ENV}-docdb-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "robo-${var.ENV}-docdb-subnet-group"
  }
}


