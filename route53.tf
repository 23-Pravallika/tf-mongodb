resource "aws_route53_record" "mongodb" {
  zone_id = data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_ID
  name    = "mongodb-${var.ENV}"
  type    = "CNAME"
  ttl     = 10
  records = [aws_docdb_cluster.docdb.endpoint]
}

# A Record     : Creating Name to an IP Address
# CNAME Record : Creating Name to a Name


