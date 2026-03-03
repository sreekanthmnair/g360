# variables.tf

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to store the Terraform state"
  type        = string
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table for state locking"
  type        = string
}

variable "region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "us-east-1"  # Default region, can be overridden
}