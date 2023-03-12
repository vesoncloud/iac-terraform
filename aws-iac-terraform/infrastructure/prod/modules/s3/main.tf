//************************************************************************************
// aws S3
//************************************************************************************
locals {
  s3_bucket_name         = var.s3_bucket_name
  s3_bucket_acl_value    = var.s3_bucket_acl_value
  s3_folders             = var.s3_folders
}

//*************************************************************************************
// S3 bucket name
//*************************************************************************************
resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = local.s3_bucket_name

  lifecycle {
    prevent_destroy = true
  }
}

// disable public access to s3 bucket
resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.my_s3_bucket.bucket
  acl    = local.s3_bucket_acl_value
}

// disable versioning for s3
resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.my_s3_bucket.bucket

  versioning_configuration {
    status =  "Disabled"
}

// enable server-side encryption for s3
}
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_server_side_encryption" {
  bucket = aws_s3_bucket.my_s3_bucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

// create the folders in s3 bucket
resource "aws_s3_object" "s3_objects_creation" {
  bucket    = aws_s3_bucket.my_s3_bucket.bucket
  for_each  = local.s3_folders
  key       = each.key

  force_destroy = true
}




