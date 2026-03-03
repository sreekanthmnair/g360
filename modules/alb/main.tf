# modules/alb/main.tf

resource "aws_lb" "web_lb" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.web_lb_sg_id]
  subnets            = var.public_subnets
  enable_deletion_protection = false

  tags = var.tags
}

resource "aws_lb_target_group" "web_lb" {
  name        = "web-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
  
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = var.tags
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_lb.arn
  }

  tags = var.tags
}