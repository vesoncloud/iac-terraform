//************************************************************************************
// aws Secrets Manager
//************************************************************************************
locals {
  my_secret_name       = var.my_secret_name
  my_aws_secret_string = var.my_aws_secret_string
}

//************************************************************************************
// aws secrets manager
//************************************************************************************
resource "aws_secretsmanager_secret" "my_secrets_manager" {
  name = local.my_secret_name
}

//************************************************************************************
// aws secrets manager version
//************************************************************************************
resource "aws_secretsmanager_secret_version" "my_secrets_manager_secret_version" {
  secret_id     = aws_secretsmanager_secret.my_secrets_manager.id
  secret_string = jsonencode(local.my_aws_secret_string)

  version_stages = ["AWSCURRENT"]
}










