//********************************************************************
// AWS terraform variables
//********************************************************************
// this the aws region
variable "aws_region" {
  description = "This is the aws region to deploy the infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "This is the s3 bucket name"
  type        = string
  default     = "snowflake-staging-2023"
}

variable "s3_bucket_acl_value" {
  description = "This makes s3 private"
  type        = string
  default     = "private"
}

variable "s3_folders" {
  description = "These are the s3 folder names"
  type        = set(string)
  default     = ["sales/", "accounts/", "HR/", "Inventory/"]
}













