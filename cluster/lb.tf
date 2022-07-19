resource "aws_lb" "lb" {
  name               = "test-http-elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.load_balancers.id}"]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = false
}


# # Create target group
resource "aws_alb_target_group" "default" {
  name                 = "tg-default"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = aws_vpc.main.id
  deregistration_delay = var.deregistration_delay

  health_check {
    path     = var.health_check_path
    protocol = "HTTP"
  }
}

# Add HTTP listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.default.arn
    type             = "forward"
  }
}
