resource "aws_autoscaling_group" "servers" {
    name     = var.asg_name
    max_size = var.max_size
    min_size = var.min_size

    launch_configuration = aws_launch_configuration.servers_launch_config.name
    vpc_zone_identifier  = var.vpc_zone_identifier

    health_check_grace_period = 300
    health_check_type         = "EC2"

    tags = var.asg_tags
}

resource "aws_launch_configuration" "servers_launch_config" {
    name_prefix = "${var.lc_name}-"

    iam_instance_profile = var.instance_profile
    image_id             = var.image_id
    instance_type        = var.instance_type
    key_name             = var.key_name
    security_groups      = var.security_groups
    user_data            = var.user_data

    associate_public_ip_address = false

    root_block_device {
        volume_size = var.volume_size
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_attachment" "public_asg_attachment" {
    autoscaling_group_name = aws_autoscaling_group.servers.id
    alb_target_group_arn   = var.lb_target_arn
}
