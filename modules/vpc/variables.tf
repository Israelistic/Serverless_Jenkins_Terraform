#-----vpc/variables.tf-----
#===========================
variable "region" {
  type    = string
  default = "ca-central-1"
}
#DOMAIN_NAME
domain_name         = "canadaclouds"
#ELB
variable "elb_healthy_threshold" {}
variable "elb_unhealthy_threshold" {}
variable "elb_timeout" {}
variable "elb_interval" {}
# AUTOSCALING
variable "asg_max" {}
variable "asg_min" {}
variable "asg_grace" {}
variable "asg_hct" {}
variable "asg_cap" {}

#DNS
variable "delegation_set" {}