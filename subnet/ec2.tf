
resource "aws_launch_template" "presentation_tier" {
  name = "presentation_tier"


  instance_type = "t2.micro"
  image_id      = var.ASG_AMI

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.security_groups_presentation
  }
}

resource "aws_launch_template" "application_tier" {
  name = "application_tier"


  instance_type = "t2.micro"
  image_id      = var.ASG_AMI

  network_interfaces {
    associate_public_ip_address = false
    security_groups = var.security_groups_application
  }


}