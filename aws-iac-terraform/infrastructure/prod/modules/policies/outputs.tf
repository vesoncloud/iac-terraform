// IAM roles/policies arn and names
output "gathering_ec2_config_role_arn" {
  value = aws_iam_role.gathering_ec2_config_role.arn
}

output "gathering_ec2_config_role_name" {
  value = aws_iam_role.gathering_ec2_config_role.name
}

output "aws_daily_ec2_config_role_arn" {
  value = aws_iam_role.aws_daily_ec2_config_role.arn
}

output "aws_daily_ec2_config_role_name" {
  value = aws_iam_role.aws_daily_ec2_config_role.name
}