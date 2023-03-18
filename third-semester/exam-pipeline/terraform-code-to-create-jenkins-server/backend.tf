terraform {
  backend "s3" {
    bucket = "kubernetes-app"
    region = "us-east-1"
    key = "jenkins-server/terraform.tfstate"
  }
}