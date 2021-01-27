# load balancer
variable "lb_name" {}
variable "internal" {}
variable "security_group_ids" {}
variable "public_subnet_ids" {}
variable "ssl_cert_arn" {}
variable "lb_tags" {}

# target group
variable "lbt_name" {}
variable "vpc_id" {}
variable "lbt_tags" {}

# target group health check
variable "interval" {}
variable "path" {}
variable "port" {}
variable "timeout" {}
variable "healthy_threshold" {}
variable "unhealthy_threshold" {}
variable "matcher" {}
