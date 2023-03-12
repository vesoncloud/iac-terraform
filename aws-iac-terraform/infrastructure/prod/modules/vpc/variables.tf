// this the aws region
variable "aws_region" {
  description = "This is the aws region to deploy the infrastructure"
  type        = string
  default     = "us-east-1"
}

// this is the vpc cidr block
variable "vpc_cidr" {
  description = "This is my Production-VPC cidr"
  type        = string
  default     = "10.0.0.0/16"
}

// this is the vpc name
variable "vpc_name" {
  description = "This is the name of my Production-VPC"
  type        = string
  default     = "Production-VPC"
}

// this is the public subnet name
variable "production_subnet_public_1_us_east_1a" {
  description = "this is the name for public subnet"
  type        = string
  default     = "production-subnet-public-1-us-east-1a"
}

// this is the private subnet name
variable "production_subnet_private_1_us_east_1b" {
  description = "this is the name for private subnet"
  type        = string
  default     = "production-subnet-private-1-us-east-1b"
}

// this is the cidr block for public-subnet-1
variable "public_subnet_1_cidr" {
  description = "this is the cidr block for public-subnet-1"
  type        = string
  default     = "10.0.1.0/24"
}

// this is the cidr block for private-subnet-1
variable "private_subnet_1_cidr" {
  description = "this is the cidr block for private-subnet-1"
  type        = string
  default     = "10.0.2.0/24"
}

// this is the us-east-1a availability zone name
variable "us_east_1a" {
  description = "this is the availability zone name for us-east-1a"
  type        = string
  default     = "us-east-1a"
}

// this is the us-east-1b availability zone name
variable "us_east_1b" {
  description = "this is the availability zone name for us-east-1b"
  type        = string
  default     = "us-east-1b"
}

// this is for public route table
variable "public_subnet_1_route_table" {
  description = "this is the name for public-subnet-1 route table"
  type        = string
  default     = "public-route-table"
}

// this is for private route table
variable "private_subnet_1_route_table" {
  description = "this is the name for private-subnet-1 route table"
  type        = string
  default     = "private-route-table"
}

// this for Internet Gateway (IGW)
variable "production_igw" {
  description = "this is the IGW for production-VPC"
  type        = string
  default     = "Production-IGW"
}

// this destination for internet
variable "igw_destination_cidr_block" {
  description = "this is the IGW destination cidr block"
  type        = string
  default     = "0.0.0.0/0"
}




