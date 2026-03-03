# main.tf

# Backend Configuration for Storing Terraform State in S3 Bucket
terraform {
  backend "s3" {
    bucket         = "my-g360-terraform-state-bucket"  # Replace with your S3 bucket name
    key            = "terraform.tfstate"                 # The file name for the state file
    region         = "us-east-1"                         # AWS region
    encrypt        = true                                # Enable encryption for state file
    dynamodb_table = "terraform-locks"                   # DynamoDB table for state locking
    acl            = "private"                           # Private access control list
  }
}

# VPC Module
module "vpc" {
  source         = "./modules/vpc"
  vpc_name       = var.vpc_name
  vpc_cidr       = var.vpc_cidr
  azs            = var.azs
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  tags           = var.tags
}

# Security Groups Module
module "security_groups" {
  source      = "./modules/sg"
  vpc_id      = module.vpc.vpc_id
  alb_sg_name = "web-alb-sg"
  ec2_sg_name = "web-ec2-sg"
  tags        = var.tags
}

# ALB Module
module "alb" {
  source             = "./modules/alb"
  vpc_id             = module.vpc.vpc_id
  public_subnets     = module.vpc.public_subnets
  web_lb_sg_id       = module.security_groups.alb_sg_id
  tags               = var.tags
}

# Auto Scaling Group Module
module "asg" {
  source = "./modules/asg"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  ec2_sg_id         = module.security_groups.ec2_sg_id
  private_subnets   = module.vpc.private_subnets
  target_group_arns = [module.alb.target_group_arn]

  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size
}

# Outputs
output "target_group_arn" {
  value = module.alb.target_group_arn
}

output "asg_name" {
  value = module.asg.asg_name
}