#creates the cluster
resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "robo-${var.ENV}-docdb"
  engine                  = "docdb"
  master_username         = local.DOCDB_USER
  master_password         = local.DOCDB_PASSWD
#   backup_retention_period = 5
#   preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_docdb_subnet_group.docdb_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.allow-docdb.id]
#  storage_type            = iopt1
}

# Creates Subnet Group Needed to host the docdb cluster 
resource "aws_docdb_subnet_group" "docdb_subnet_group" {
  name       = "robo-${var.ENV}-docdb-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_ID

  tags = {
    Name = "robo-${var.ENV}-docdb-subnet-group"
  }
}

# Creates Instances Needed for the DocDB Cluster
resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = var.DOCDB_INSTANCE_COUNT
  identifier         = "robo-${var.ENV}-docdb-cluster-instance"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = var.DOCDB_INSTANCE_CLASS
    depends_on = [
      aws_docdb_cluster.docdb
    ]
}

