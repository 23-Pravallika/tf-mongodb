# Whenever you have some common fields or anything which is highly used, you can consider that in locals and can call it on your need

locals {
    DOCDB_USER = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["DOCDB_USR"]
    DOCDB_PASSWD = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["DOCDB_PASS"]
}




