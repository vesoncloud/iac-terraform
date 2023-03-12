// my vpc id and name
output "vpc_id" {
  value = aws_vpc.production_vpc.id
}

output "vpc_name" {
  value = aws_vpc.production_vpc.id
}

// public subnet id
output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

// private subnet id
output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}

