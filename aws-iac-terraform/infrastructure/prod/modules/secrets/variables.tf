//********************************************************************
// AWS terraform variables
//********************************************************************
// this the aws region
variable "aws_region" {
  description = "This is the aws region to deploy the infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "my_secret_name" {
  description = "This is the secret name"
  type        = string
  default     = "prod/db/dhs"
}

// create the secret string to store secret values
variable "my_aws_secret_string" {
  description = "This is the secret string to store secret"
  type        = map(string)
  default     = {
    region: "us-east-1"
    secret_access_key: "aaaaabbbbbcccccdddd12345"
    access_key_id: "12345mmmmddddfffggghhh"
  }
}





