resource "aws_route53_zone" "altschool_project_hosted_zone" {
  name = var.domain_name
  tags = {
    Name        = "altschool_project_hosted_zone"
    Environment = "dev"
  }
}


resource "aws_route53_record" "altschool_project_record" {
  zone_id = aws_route53_zone.altschool_project_hosted_zone.zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = aws_lb.altschool_project_lb.dns_name
    zone_id                = aws_lb.altschool_project_lb.zone_id
    evaluate_target_health = true
  }
}
