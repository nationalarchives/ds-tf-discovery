# launch configuration
variable "lc_name" {}
variable "image_id" {}
variable "instance_type" {}
variable "instance_profile" {}
variable "key_name" {}
variable "user_data" {}
variable "volume_size" {}
variable "security_groups" {}

# autoscaling group
variable "asg_name" {}
variable "min_size" {}
variable "max_size" {}
variable "vpc_zone_identifier" {}
variable "asg_tags" {}

# autoscaling group attachment
variable "lb_target_arn" {}
