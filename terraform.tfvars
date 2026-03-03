# terraform.tfvars

# VPC / Networking
vpc_name        = "web-tier-vpc"
vpc_cidr        = "10.0.0.0/16"
azs             = ["us-east-1a", "us-east-1b"]
private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

# EC2 / Launch Template

ami_id        = "ami-0e4992f40d2f2eafb"
instance_type = "t2.micro"
key_name      = "webtier"

# Auto Scaling Group
desired_capacity = 2
min_size         = 1
max_size         = 3

# Tags
tags = {
  Project     = "G360"
  Environment = "dev"
}

# S3 Bucket for Backend State
s3_bucket_name = "my-g360-terraform-state-bucket"  # Replace with your bucket name
