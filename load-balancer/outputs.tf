output "lb_arn_suffix" {
    value = aws_lb.lb.arn_suffix
}

output "lb_target_arn" {
    value = aws_lb_target_group.servers_lb_target.arn
}
