

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"  # Use the official AWS provider from HashiCorp
      version = "~> 4.0"         # This will use version 4.x of the AWS provider (adjust version as needed)
    }
  }

  required_version = ">= 1.0"  # Enforces a minimum Terraform version of 1.0
}

provider "aws" {
  region = var.region  # The region is fetched from the variables file
}