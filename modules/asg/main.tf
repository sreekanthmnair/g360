# modules/asg/main.tf

resource "aws_launch_template" "web_lt" {
  name_prefix   = "web-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [var.ec2_sg_id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              systemctl enable nginx
              systemctl start nginx
              EOF
  )

  metadata_options {
    http_tokens = "required"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  vpc_zone_identifier = var.private_subnets
  desired_capacity    = var.desired_capacity
  min_size            = var.min_size
  max_size            = var.max_size
  target_group_arns   = var.target_group_arns

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  health_check_type         = "ELB"
  health_check_grace_period = 60

  tag {
    key                 = "Name"
    value               = "web-asg"
    propagate_at_launch = true
  }
}