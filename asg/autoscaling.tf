resource "aws_autoscaling_group" "presentation_tier" {
  name                      = "Launch-Temp-ASG-Pres-Tier"
  max_size                  = var.ASG_MAX_INSTANCE
  min_size                  = var.ASG_MIN_INSTANCE
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = var.ASG_DESIRED_CAPACITY
  vpc_zone_identifier       = var.VPC_ZONE

  launch_template {
    id      = var.presentation_tier_template
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "presentation_app"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "application_tier" {
  name                      = "Launch-Temp-ASG-App-Tier"
  max_size                  = var.ASG_MAX_INSTANCE
  min_size                  = var.ASG_MIN_INSTANCE
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = var.ASG_DESIRED_CAPACITY
  vpc_zone_identifier       = var.VPC_ZONE_APPLICATION

  launch_template {
    id      = var.application_tier_template
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }

  tag {
    key                 = "Name"
    value               = "application_app"
    propagate_at_launch = true
  }
}

# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "presentation_tier" {
  autoscaling_group_name = aws_autoscaling_group.presentation_tier.id
  lb_target_group_arn    = var.TG_ARN
}

resource "aws_autoscaling_attachment" "application_tier" {
  autoscaling_group_name = aws_autoscaling_group.application_tier.id
  lb_target_group_arn    = var.TG_ARN_APPLICATION
}