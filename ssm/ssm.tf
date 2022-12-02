resource "aws_ssm_parameter" "presntation_lb" {
  name = "external_lb"
  type = "String"
  value = var.ELB_DNS
}
resource "aws_ssm_parameter" "application_lb" {
  name = "internal_lb"
  type = "String"
  value = var.ELB_DNS_APPLICATION
}