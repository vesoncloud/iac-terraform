# outputs for EC2
output "public_security_group_id" {
  value = aws_security_group.ec2_public_security_group.arn
}

