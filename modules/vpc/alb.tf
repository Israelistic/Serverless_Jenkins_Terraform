######################Elastic Load Balancer####################
resource "aws_elb" "north_pole_wp_elb" {

  #the name of the domain -elb
  name = "${var.domain_name}-elb-north-pole"
  #pointing the subnets the ELB will use
  subnets = ["${aws_subnet.north_pole_public1_sunbet.id}", "${aws_subnet.north_pole_public2_sunbet.id}"]
  #pointing the security group the ELB will use
  security_groups = ["${aws_security_group.shared_services_public_sg.id}"]
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
    Name = "north_pole_wp_${var.domain_name}-elb"
  }


}