resource "aws_lb" "Alb" {
  name            = var.ELB_NAME
  internal = false
  load_balancer_type = var.LB_TYPE  
  subnets         = var.PUBLIC_SUBNET_ID
  security_groups = var.SG
  

  tags = {
    Name = "java-elb"
  }
}



resource "aws_lb_target_group" "target_group" {
  name        = "tf-lb-tg"
  target_type = "instance"
  health_check {
    matcher = "200,404"
    interval = "10"
  }
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.TG_VPC
}
// application lb balamcer

resource "aws_lb" "application_tier" {
  name               = var.ELB_NAME_APPLICATION
  internal           = true
  load_balancer_type = var.LB_TYPE
  security_groups    = var.SG_APPLICATION
  subnets            = var.PRIVATE_SUBNET_ID

  enable_deletion_protection = false
}

resource "aws_lb_listener" "application_tier" {
  load_balancer_arn = aws_lb.application_tier.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.application_tier.arn
  }
}

resource "aws_lb_target_group" "application_tier" {
  name     = "application-tier-lb-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.TG_VPC
}