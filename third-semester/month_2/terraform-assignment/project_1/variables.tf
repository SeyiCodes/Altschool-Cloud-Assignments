variable "region" {
  default = "eu-west-1"
}

variable "project_name" {
  default = "altschool_project"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}


variable "public_subnet_cidr_az1" {
  default = "10.0.1.0/24"
}

variable "public_subnet_cidr_az2" {
  default = "10.0.2.0/24"
}

variable "public_subnet_cidr_az3" {
  default = "10.0.3.0/24"
}

variable "anywhere_cidr" {
  default = "0.0.0.0/0"
}

variable "access_key" {
  default = "example_access_key"
}

variable "secret_key" {
  default = "example_secret_key"
}

variable "ami" {
  default = "ami-0c68b55d1c875067e"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "domain_name" {
  default     = "seyiakinnawo.live"
  type        = string
  description = "Domain name"
}
