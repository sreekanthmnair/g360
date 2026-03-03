# main.tf

# S3 Bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.s3_bucket_name  # Use variable for bucket name

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "dev"
  }
}

# Block public access for the S3 bucket using the aws_s3_bucket_public_access_block resource
resource "aws_s3_bucket_public_access_block" "terraform_state_public_access_block" {
  bucket = aws_s3_bucket.terraform_state.bucket

  block_public_acls    = true
  block_public_policy  = true
  ignore_public_acls   = true
  restrict_public_buckets = true
}

# Enable versioning using the aws_s3_bucket_versioning resource
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

# DynamoDB Table for state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_table_name  # Use variable for table name
  billing_mode = "PAY_PER_REQUEST"        # On-demand pricing
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = "dev"
  }
}

# Output S3 bucket name after successful creation
output "s3_bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "The name of the S3 bucket for Terraform state"
}

# Output DynamoDB table name after successful creation
output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of the DynamoDB table for Terraform state locking"
}