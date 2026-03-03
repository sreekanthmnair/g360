
# modules/alb/variables.tf

variable "vpc_id" {
  description = "VPC ID to create the ALB in"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets to deploy the ALB in"
  type        = list(string)
}

variable "web_lb_sg_id" {
  description = "Security group ID to associate with the ALB"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the ALB and associated resources"
  type        = map(string)
  default     = {}
}