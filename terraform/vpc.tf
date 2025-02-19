resource "aws_vpc" "wordpress" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_internet_gateway" "wordpress" {
  vpc_id = aws_vpc.wordpress.id
}

resource "aws_default_route_table" "wordpress" {
  default_route_table_id = aws_vpc.wordpress.main_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wordpress.id
  }
}

resource "aws_subnet" "wordpress" {
  for_each          = var.vpc_subnets_by_az
  availability_zone = each.key
  cidr_block        = each.value
  vpc_id            = aws_vpc.wordpress.id
}