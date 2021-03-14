resource "aws_lb" "lb" {
    name     = var.lb_name
    internal = var.internal

    load_balancer_type = "application"
    security_groups    = var.security_group_ids

    subnets = var.subnet_ids

    tags = var.lb_tags
}

resource "aws_lb_listener" "http_lb_listener" {
    default_action {
        type = "redirect"

        redirect {
            status_code = "HTTP_301"
            port        = "443"
            protocol    = "HTTPS"
        }
    }
    load_balancer_arn = aws_lb.lb.arn
    port              = 80
}

resource "aws_lb_listener" "https_lb_listener" {
    default_action {
        target_group_arn = aws_lb_target_group.servers_lb_target.arn
        type             = "forward"
    }

    protocol          = "HTTPS"
    load_balancer_arn = aws_lb.lb.arn
    certificate_arn   = var.ssl_cert_arn
    ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
    port              = 443
}
