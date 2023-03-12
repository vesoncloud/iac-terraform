// secrets manager output
output "my_secret_manager_arn" {
  value = aws_secretsmanager_secret_version.my_secrets_manager_secret_version.arn
}

output "my_secret_manager_name" {
  value = aws_secretsmanager_secret.my_secrets_manager.name
}
