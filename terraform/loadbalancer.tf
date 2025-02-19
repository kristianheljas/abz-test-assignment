resource "aws_lb" "wordpress" {
  name               = "wordpress"
  internal           = false
  load_balancer_type = "application"
  subnets            = values(aws_subnet.wordpress)[*].id
  security_groups = [
    aws_vpc.wordpress.default_security_group_id,
    aws_security_group.public_ingress_http_and_https.id,
  ]
}

resource "aws_lb_target_group" "wordpress" {
  name     = "wordpress"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.wordpress.id
}

resource "aws_lb_target_group_attachment" "wordpress" {
  target_group_arn = aws_lb_target_group.wordpress.arn
  target_id        = aws_instance.wordpress.id
  port             = 80
}

resource "aws_lb_listener" "wordpress_http" {
  load_balancer_arn = aws_lb.wordpress.arn
  port              = 80
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "wordpress_https" {
  load_balancer_arn = aws_lb.wordpress.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate_validation.wordpress.certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress.arn
  }
}

resource "aws_route53_record" "wordpress" {
  zone_id = data.aws_route53_zone.wordpress.zone_id
  name    = var.dns_name
  type    = "CNAME"
  ttl     = 60
  records = [aws_lb.wordpress.dns_name]
}
