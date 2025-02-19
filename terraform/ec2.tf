resource "aws_key_pair" "default" {
  key_name   = "default"
  public_key = var.default_ssh_key
}

resource "aws_instance" "wordpress" {
  tags = {
    Name = "wordpress"
  }
  ami                         = "ami-03fd334507439f4d1" # Ubuntu 24.04 x86_64
  instance_type               = var.ec2_instance_type
  subnet_id                   = values(aws_subnet.wordpress)[0].id
  key_name                    = aws_key_pair.default.key_name
  depends_on                  = [aws_internet_gateway.wordpress]
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_vpc.wordpress.default_security_group_id,
    aws_security_group.public_ingress_ssh.id,
  ]

}

output "wordpress_public_ip" {
  value = aws_instance.wordpress.public_ip
}