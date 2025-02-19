data "aws_route53_zone" "wordpress" {
  name = "${var.dns_zone_name}."
}