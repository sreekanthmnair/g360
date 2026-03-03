packer {
  required_version = ">= 1.9.0"

  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t3.micro"
}

source "amazon-ebs" "amazon_linux_nginx" {
  region        = var.aws_region
  instance_type = var.instance_type

  source_ami_filter {
    filters = {
      "name"                = "amzn2-ami-hvm-*-x86_64-gp2"
      "virtualization-type" = "hvm"
    }
    owners      = ["137112412989"]   # Official Amazon owner ID for Amazon Linux 2
    most_recent = true
  }

  ssh_username = "ec2-user"
  ami_name     = "web-tier-nginx-{{timestamp}}"
}

build {
  sources = ["source.amazon-ebs.amazon_linux_nginx"]

  provisioner "shell" {
    inline = [
      "sudo amazon-linux-extras enable nginx1",
      "sudo amazon-linux-extras install nginx1 -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "echo '<h1>Welcome to Web Tier</h1>' | sudo tee /usr/share/nginx/html/index.html"
    ]
  }
}