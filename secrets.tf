resource "aws_secretsmanager_secret" "db_password" {
  name                    = "${var.name}-db-password"
  description             = "Database password for ${var.name}"
  recovery_window_in_days = 7

  tags = local.tags
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
    endpoint = aws_rds_cluster.main.endpoint
    port     = 3306
    dbname   = var.db_name
  })
}