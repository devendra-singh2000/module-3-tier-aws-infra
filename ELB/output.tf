output "ELB_ID" {
    value = aws_lb.Alb.id 
}
output "ELB_DNS" {
    value = aws_lb.Alb.dns_name
  
}
 output "TG_ARN" {
    value = aws_lb_target_group.target_group.arn
  
} 
output "ZONE_ID_ALB" {
    value = aws_lb.Alb.zone_id
}
// appliaction lb
output "ELB_ID_APPLICATION" {
  value = aws_lb.application_tier.id
}
output "ELB_DNS_APPLICATION" {
  value = aws_lb.application_tier.dns_name
}
output "TG_ARN_APPLICATION" {
  value = aws_lb_target_group.application_tier.arn
}
output "ZONE_ID_ELB_APPLICATION" {
  value = aws_lb.application_tier.zone_id
}