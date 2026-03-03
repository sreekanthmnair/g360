# modules/sg/variables.tf

variable "vpc_id" {
  description = "VPC ID where the security groups will be created"
  type        = string
}

variable "alb_sg_name" {
  description = "Name for the ALB security group"
  type        = string
}

variable "ec2_sg_name" {
  description = "Name for the EC2 security group"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the security group resources"
  type        = map(string)
  default     = {}
}