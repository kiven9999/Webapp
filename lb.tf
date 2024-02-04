resource "aws_lb" "my_lb" {
  name               = "my-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.lb_sg.id]
  subnets            = [data.aws_subnet.east_2a.id, data.aws_subnet.east_2b.id, data.aws_subnet.east_2c.id]
}

resource "aws_lb_target_group" "my_target_group" {
  name                 = "webapp-tg-page1"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = data.aws_vpc.ecs_vpc.id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "my_lb_listener" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}

resource "aws_lb_listener_rule" "redirect_page1" {
  listener_arn = aws_lb_listener.my_lb_listener.arn
  priority     = 100

  action {
    type = "redirect"
    redirect {
      path        = "/page1.html"
      port        = "80"
      protocol    = "HTTP"
      status_code = "HTTP_301"
    }
  }

  condition {
    path_pattern {
      values = ["/page1"]
    }
  }
}

resource "aws_lb_listener_rule" "redirect_page2" {
  listener_arn = aws_lb_listener.my_lb_listener.arn
  priority     = 101

  action {
    type = "redirect"
    redirect {
      path        = "/page2.html"
      port        = "80"
      protocol    = "HTTP"
      status_code = "HTTP_301"
    }
  }

  condition {
    path_pattern {
      values = ["/page2"]
    }
  }
}
