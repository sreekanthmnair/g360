
# variables.tf

# VPC / Networking Variables
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "Availability zones to deploy subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

# EC2 / Launch Template Variables
variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "SSH key name (optional)"
  type        = string
  default     = ""
}

# Auto Scaling Variables
variable "desired_capacity" {
  description = "Desired number of EC2 instances"
  type        = number
}

variable "min_size" {
  description = "Minimum size of the ASG"
  type        = number
}

variable "max_size" {
  description = "Maximum size of the ASG"
  type        = number
}

# Tags Variable
variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}

# Variable to define the S3 bucket name for storing the Terraform state file
variable "s3_bucket_name" {
  description = "The name of the S3 bucket for storing the Terraform state file"
  type        = string
}