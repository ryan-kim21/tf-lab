#-------------------------------------------------------------------------------
resource "aws_launch_template" "web" {
  name                   = "WebServer-Highly-Available-LT"
  image_id               = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data              = filebase64("${path.module}/user_data.sh")

  # 추가 설정 및 속성
}

resource "aws_autoscaling_group" "web" {
  name                = "WebServer-Highly-Available-ASG-Ver-${aws_launch_template.web.latest_version}"
  min_size            = 1
  max_size            = 3
  min_elb_capacity    = 2
  health_check_type   = "ELB"
  vpc_zone_identifier = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
  target_group_arns   = [aws_lb_target_group.web.arn]

  launch_template {
    id      = aws_launch_template.web.id
    version = aws_launch_template.web.latest_version
  }

  dynamic "tag" {
    for_each = {
      Name   = "WebServer in ASG-v${aws_launch_template.web.latest_version}"
      TAGKEY = "TAGVALUE"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}
