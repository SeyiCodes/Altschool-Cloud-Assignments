terraform {
  backend "s3" {
    bucket = "kubernetes-app"
    region = "us-east-1"
    key = "eks/terraform.tfstate"
  }
}