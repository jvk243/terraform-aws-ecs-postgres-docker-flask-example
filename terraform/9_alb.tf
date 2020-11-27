# create the ALB
resource "aws_alb" "alb" {
  load_balancer_type = "application"
  name = "application-load-balancer"
  subnets = aws_subnet.public_subnets.*.id
  security_groups = [aws_security_group.alb_sg.id]
}

# point redirected traffic to the app
resource "aws_alb_target_group" "target_group" {
  name = "ecs-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

# direct traffic through the ALB
resource "aws_alb_listener" "fp-alb-listener" {
  load_balancer_arn = aws_alb.alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.target_group.arn
    type = "forward"
  }
}
