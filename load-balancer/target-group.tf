resource "aws_lb_target_group" "servers_lb_target" {
    name     = var.lbt_name
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id

    health_check {
        interval            = var.interval
        path                = var.path
        port                = var.port
        timeout             = var.timeout
        healthy_threshold   = var.healthy_threshold
        unhealthy_threshold = var.unhealthy_threshold
        matcher             = var.matcher
    }

    tags = var.lbt_tags
}
