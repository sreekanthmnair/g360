# modules/alb/outputs.tf

output "target_group_arn" {
  value = aws_lb_target_group.web_lb.arn
}