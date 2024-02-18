## Creates Security Group 
resource "aws_security_group" "allow-docdb" {
 name        = "robo-${var.ENV}-docdb-sg"
 description = "Allows MongoDB Internal inbound traffic"
 vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID 
 
ingress {
   description = "Allows docdb from local network"
   from_port   = var.DOCDB_PORT
   to_port     = var.DOCDB_PORT
   protocol    = "tcp"
   cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
 }

ingress {
   description = "Allows docdb from default network"
   from_port   = var.DOCDB_PORT
   to_port     = var.DOCDB_PORT
   protocol    = "tcp"
   cidr_blocks = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
 }

egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

tags = {
    Name = "allow-docdb"
  }
}


