resource "aws_autoscaling_group" "int_servers" {
    name     = "${var.resource_prefix}-asg-web-internal"
    max_size = var.max_size
    min_size = var.min_size

    launch_configuration = aws_launch_configuration.int_servers_launch_config.name
    vpc_zone_identifier  = var.vpc_zone_identifier

    health_check_grace_period = 300
    health_check_type         = "EC2"

    tags = list(
    map("key", "Terraform", "value", "true", "propagate_at_launch", true),
    map("key", "LaunchedBy", "value", "ASG", "propagate_at_launch", true),
    map("key", "Service", "value", "private", "propagate_at_launch", true),
    map("key", "Name", "value", "${var.resource_prefix}-ec2-web-internal", "propagate_at_launch", true),
    map("key", "Product", "value", var.product, "propagate_at_launch", true),
    map("key", "CostCentre", "value", var.costcentre, "propagate_at_launch", true),
    map("key", "Environment", "value", var.environment, "propagate_at_launch", true),
    map("key", "Owner", "value", var.owner, "propagate_at_launch", true),
    map("key", "CreatedBy", "value", var.created_by, "propagate_at_launch", true)
    )
}

resource "aws_launch_configuration" "int_servers_launch_config" {
    iam_instance_profile = var.instance_profile
    name_prefix          = "${var.resource_prefix}-lc-web-internal-"
    image_id             = var.image_id
    instance_type        = var.instance_type
    key_name             = "disco-wincore-${var.environment}-web"
    security_groups      = var.security_groups

    root_block_device {
        volume_size = var.volume_size
    }

    user_data = var.user_data

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_attachment" "public_asg_attachment" {
    autoscaling_group_name = aws_autoscaling_group.int_servers.id
    alb_target_group_arn   = var.lb_target_arn
}
