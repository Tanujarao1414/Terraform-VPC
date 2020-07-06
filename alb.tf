resource "aws_lb" "front_end" {
  name               = "test-lb-tf"
  internal           = false
  security_groups    = ["${aws_security_group.sgweb.id}"]
  subnets            = ["${aws_subnet.public-subnet1.id}","${aws_subnet.public-subnet2.id}"]

  enable_deletion_protection = false

  tags = {
    Environment = "Production"
  }
}
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.front_end.arn}"
  port              = "80"
  protocol          = "HTTP"

    default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.alb_front_https_tg.arn}"
  }
}

resource "aws_alb_target_group" "alb_front_https_tg" {
	name	= "alb-front-https"
	vpc_id	= "${aws_vpc.default.id}"
	port	= "80"
	protocol	= "HTTP"
	health_check {
                protocol = "HTTP"
                healthy_threshold = 2
                 unhealthy_threshold = 2
                interval = 5
                timeout = 4
                matcher = "200-308"
        }
}

resource "aws_alb_target_group_attachment" "alb_backend-01_http" {
  target_group_arn = "${aws_alb_target_group.alb_front_https_tg.arn}"
  target_id        = "${aws_instance.ec2-user.id}"
  port             = 80
}

resource "aws_alb_target_group_attachment" "alb_backend-02_http" {
  target_group_arn = "${aws_alb_target_group.alb_front_https_tg.arn}"
  target_id        = "${aws_instance.ec2-user2.id}"
  port             = 80
}


