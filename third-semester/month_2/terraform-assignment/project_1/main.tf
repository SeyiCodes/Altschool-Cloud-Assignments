provider "aws" {
  region                      = var.region
  access_key                  = var.access_key
  secret_key                  = var.secret_key
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}


resource "local_file" "public_ip" {
  filename ="./ansible/host-inventory"
  content  = <<EOT
  ${aws_instance.my_server-1.public_ip}
  ${aws_instance.my_server-2.public_ip}
  ${aws_instance.my_server-3.public_ip}
  EOT
}
