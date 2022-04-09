######################Elastic Load Balancer####################
resource "aws_elb" "shered" {

  #the name of the domain -elb
  name = "${var.domain_name}-shered_services_serverless_jenkins"
  #pointing the subnets the ELB will use
  subnets = ["${aws_subnet.shared_services_public_subnet_1.id}", "${aws_subnet.shared_services_public_subnet_2.id}"]
  #pointing the security group the ELB will use
  security_groups = ["${shared_services_serverless_jenkins_public_sg.id}"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold = var.elb_healthy_threshold
    # The time require for to deem the instance unhealty
    unhealthy_threshold = var.elb_unhealthy_threshold
    timeout             = var.elb_timeout
    target              = "TCP:80"
    interval            = var.elb_interval
  }
  #  to distribute the load between all the instances in all the AZ's
  cross_zone_load_balancing = true
  #
  idle_timeout = 400
  # allow instances finish trafic before the elb is destroyed
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "shered_services_serverless_jenkins_${var.domain_name}-elb"
  }


}