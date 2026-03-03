# terraform.tfvars

s3_bucket_name        = "my-g360-terraform-state-bucket"  # Replace with your actual S3 bucket name
dynamodb_table_name   = "terraform-locks"                   # Name of the DynamoDB table for state locking
region                = "us-east-1"                          # AWS region where resources will be created