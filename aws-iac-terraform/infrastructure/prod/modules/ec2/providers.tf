//************************************************************
// terraform backend configuration aws provider configuration
//************************************************************
locals {
  aws_region = var.aws_region
}

terraform {
  backend "s3" {
    region = "us-east-1"
  }
  // terraform aws provider version
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.5"
    }
  }
}
// configure the provider
provider "aws" {
  region = local.aws_region
}




