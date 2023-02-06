resource "aws_instance" "my_server-1" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.altschool_project_instance_sg.id]
  subnet_id       = aws_subnet.first_subnet.id
  key_name        = "test-key"
  tags = {
    Name   = "my_server-1"
    source = "terraform"
  }
}


resource "aws_instance" "my_server-2" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.altschool_project_instance_sg.id]
  subnet_id       = aws_subnet.second_subnet.id
  key_name        = "test-key"
  tags = {
    Name   = "my_server-2"
    source = "terraform"
  }
}

resource "aws_instance" "my_server-3" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.altschool_project_instance_sg.id]
  subnet_id       = aws_subnet.third_subnet.id
  key_name        = "test-key"
  tags = {
    Name   = "my_server-3"
    source = "terraform"
  }
}

# resource "aws_key_pair" "test-key" {
#   key_name   = "test-key"
#   public_key = tls_private_key.rsa.public_key_openssh
# }
# resource "tls_private_key" "rsa" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }
# resource "local_file" "tf-key" {
#   content  = tls_private_key.rsa.private_key_pem
#   filename = "test-key"
# }
