output "ELB_SG" {
    value = aws_security_group.elb-securitygroup.id
  
}
output "EC2_SG" {
    value = aws_security_group.ec2-securitygroup.id
}
output "RDS_SG" {
   value = aws_security_group.rds-securitygroup.id
}
output "ELB_SG_APPLICATION" {
  value = aws_security_group.alb_application_tier.id
}
output "EC2_SG_APPLICATION" {
  value = aws_security_group.application_tier.id
}