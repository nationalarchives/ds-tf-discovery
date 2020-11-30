output "internal_lb_arn_suffix" {
    value = aws_lb.internal_lb.arn_suffix
}

output "lb_target_arn" {
    value = aws_lb_target_group.int_servers_lb_target.arn
}
