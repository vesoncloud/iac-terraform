//********************************************************************
// AWS terraform variables
//********************************************************************
// this the aws region
variable "aws_region" {
  description = "This is the aws region to deploy the infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "gathering_ec2_config" {
  description = "This is the aws role/policy name for ec2 configuration"
  type        = string
  default     = "gathering-ec2-config"
}

variable "aws_daily_ec2_config"{
 description = "This is the aws role/policy name for triggering step function"
  type = string
  default = "aws-daily-ec2-config"
}

variable "s3_ec2_config_bucket_arn" {
  description = "This is the s3 bucket arn to write the ec2 configuration"
  type        = string
  default     = "arn:aws:s3:::devops-2023"
}

variable "s3_ec2_config_EC2_folder" {
  description = "This is the s3 bucket arn to write the ec2 configuration"
  type        = string
  default     = "arn:aws:s3:::devops-2023/EC2"
}