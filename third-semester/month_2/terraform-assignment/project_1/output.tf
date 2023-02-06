output "elb_target_group_arn" {
  value = aws_lb_target_group.altschool_project_target_group.arn
}
  
output "elb_dns_name" {
  value = aws_lb.altschool_project_lb.dns_name
}

output "elb_zone_id" {
  value = aws_lb.altschool_project_lb.zone_id
}
  
