variable "aws_profile" {
  type    = string
  default = "abz-test-assignment"
}

variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "dns_zone_name" {
  type        = string
  default     = "abz.prooton.ee"
  description = "Hosted zone name to create DNS records in"
}

variable "dns_name" {
  type        = string
  default     = "wordpress.abz.prooton.ee"
  description = "FQDN for wordpress installation"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.92.0.0/16"
}

variable "vpc_subnets_by_az" {
  type = map(string)
  default = {
    "eu-west-1a" = "10.92.0.0/24",
    "eu-west-1b" = "10.92.1.0/24",
    "eu-west-1c" = "10.92.2.0/24",
  }
}

variable "default_ssh_key" {
  type    = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE4/kpvV/W6k3XEIAPmuR2VHkXvY6n0OYXwhb72GdcNI kristian@kristian.ee"
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "elasticache_instance_type" {
  type    = string
  default = "cache.t3.micro"
}
