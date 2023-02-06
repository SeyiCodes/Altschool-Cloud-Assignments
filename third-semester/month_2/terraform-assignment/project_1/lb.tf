#create a security group for the load balancer
resource "aws_lb" "altschool_project_lb" {
  name               = "altschool-project-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.altschool_project_lb_sg.id]
  subnets            = [aws_subnet.first_subnet.id, aws_subnet.second_subnet.id, aws_subnet.third_subnet.id]
  depends_on = [
    aws_instance.my_server-1, aws_instance.my_server-2, aws_instance.my_server-3
  ]
  enable_deletion_protection = false
  tags = {
    Name = "altschool-project-lb"
  }

}


#create a target group to forward traffic to the instances
resource "aws_lb_target_group" "altschool_project_target_group" {
  name        = "altschool-project-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.altschool_project_vpc.id
  target_type = "instance"
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 3
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    matcher             = "200"
  }
  depends_on = [
    aws_instance.my_server-1, aws_instance.my_server-2, aws_instance.my_server-3
  ]
  tags = {
    Name = "altschool_project_target_group"
  }
}


#create a listener to forward all traffic to the target group
resource "aws_lb_listener" "altschool_project_lb_listener" {
  load_balancer_arn = aws_lb.altschool_project_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.altschool_project_target_group.arn
  }
  depends_on = [
    aws_instance.my_server-1, aws_instance.my_server-2, aws_instance.my_server-3
  ]
  tags = {
    Name = "altschool_project_lb_listener"
  }
}





#create a listener rule to forward all traffic to the target group
resource "aws_lb_listener_rule" "altschool_project_lb_listener_rule" {
  listener_arn = aws_lb_listener.altschool_project_lb_listener.arn
  priority     = 1
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.altschool_project_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}

resource "aws_lb_target_group_attachment" "altschool_project_lb_target_group_attachment-1" {
  target_group_arn = aws_lb_target_group.altschool_project_target_group.arn
  target_id        = aws_instance.my_server-1.id
  port             = 80
}
  
resource "aws_lb_target_group_attachment" "altschool_project_lb_target_group_attachment-2" {
  target_group_arn = aws_lb_target_group.altschool_project_target_group.arn
  target_id        = aws_instance.my_server-2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "altschool_project_lb_target_group_attachment-3" {
  target_group_arn = aws_lb_target_group.altschool_project_target_group.arn
  target_id        = aws_instance.my_server-3.id
  port             = 80
}