resource "aws_alb" "application_load_balancer" {
  name               = "${var.app_name}-${var.app_environment}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = aws_subnet.public.*.id
  security_groups    = [aws_security_group.load_balancer_security_group.id]

  tags = {
    Name        = "${var.app_name}-alb"
    Environment = var.app_environment
  }
}

resource "aws_security_group" "load_balancer_security_group" {
  vpc_id = aws_vpc.aws-vpc.id

  ingress {
    from_port        = 81
    to_port          = 81
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  


  tags = {
    Name        = "${var.app_name}-sg"
    Environment = var.app_environment
  }


}
####
resource "aws_lb_target_group" "target_group_1" {
  name        = "${var.app_name}-${var.app_environment}-tg1"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.aws-vpc.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "${var.app_name}-lb-tg1"
    Environment = var.app_environment
  }
}




resource "aws_lb_listener" "listener-1" {
  load_balancer_arn = aws_alb.application_load_balancer.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_1.id
  }
}

resource "aws_lb_listener_rule" "listener-1" {
  listener_arn = aws_lb_listener.listener-1.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_1.arn
  }
  condition {
    path_pattern {
      values = ["/us-east-1.api/*"]
    }
  }
}

resource "aws_lb_listener_rule" "listener-2" {
  listener_arn = aws_lb_listener.listener-1.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_2.arn
  }


  condition {
    path_pattern {
      values = ["/wor/*"]
    }
  }
}


######
resource "aws_lb_target_group" "target_group_2" {
  name        = "${var.app_name}-${var.app_environment}-tg2"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.aws-vpc.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "${var.app_name}-lb-tg2"
    Environment = var.app_environment
  }
}




# resource "aws_lb_listener" "listener-2" {
#   load_balancer_arn = aws_alb.application_load_balancer.id
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.target_group_2.id
#   }
# }






