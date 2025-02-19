resource "aws_security_group" "public_ingress_ssh" {
  name   = "public-ingress-ssh"
  vpc_id = aws_vpc.wordpress.id

  ingress {
    protocol    = "TCP"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH from anywhere"
  }
}

resource "aws_security_group" "public_ingress_http_and_https" {
  name   = "public-ingress-http-and-https"
  vpc_id = aws_vpc.wordpress.id

  ingress {
    protocol    = "TCP"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP from anywhere"
  }

  ingress {
    protocol    = "TCP"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS from anywhere"
  }
}