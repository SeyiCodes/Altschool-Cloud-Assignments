#Create a security group for the load balancer
resource "aws_security_group" "altschool_project_lb_sg" {
  name        = "altschool_project_lb_sg"
  description = "Allow inbound traffic from the internet"
  vpc_id      = aws_vpc.altschool_project_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outbound Traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "altschool_project_lb_sg"
  }

}

#create a security group for the instances
resource "aws_security_group" "altschool_project_instance_sg" {
  name        = "allow_connectivity"
  description = "Allow inbound traffic from the internet"
  vpc_id      = aws_vpc.altschool_project_vpc.id

  ingress {
    description     = "HTTP"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.altschool_project_lb_sg.id]
  }

  ingress {
    description     = "HTTPS"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.altschool_project_lb_sg.id]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "altschool_project_instance_sg"
  }
}
