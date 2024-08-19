resource aws_kms_key secret_key {
  is_enabled          = true
  enable_key_rotation = false
  multi_region        = true
  description         = "Key for RDS Proxy"
}

resource aws_kms_alias secret_key_alias {
  name          = "alias/secret-key"
  target_key_id = aws_kms_key.secret_key.key_id
}

resource aws_secretsmanager_secret rds_secret {
  name = "rds-secrets"
  kms_key_id = aws_kms_key.secret_key.key_id
}

resource aws_secretsmanager_secret_version rds_secret_password {
  secret_id = aws_secretsmanager_secret.rds_secret.id
	
  secret_string = jsonencode({
    dbClusterIdentifier = "${aws_db_instance.main.address}"
    host                = data.aws_rds_cluster.cluster.endpoint
    port                = data.aws_rds_cluster.cluster.port
    username            = data.aws_rds_cluster.cluster.master_username
    password            = var.cluster_master_password
    engine              = "mysql"
  })
}
