resource "aws_db_subnet_group" "wordpress" {
  name       = "wordpress"
  subnet_ids = values(aws_subnet.wordpress)[*].id
}

resource "random_password" "wordpress_db" {
  length  = 16
  special = false
}

resource "aws_db_instance" "wordpress" {
  identifier           = "wordpress"
  instance_class       = "db.t4g.micro"
  engine               = "mysql"
  engine_version       = "8.4.3"
  allocated_storage    = 10
  db_name              = "wordpress"
  username             = "root"
  multi_az             = false
  skip_final_snapshot  = true
  apply_immediately    = true
  password             = random_password.wordpress_db.result
  db_subnet_group_name = aws_db_subnet_group.wordpress.name
}

output "wordpress_db_host" {
  value = aws_db_instance.wordpress.address
}

output "wordpress_db_root_password" {
  sensitive = true
  value     = random_password.wordpress_db.result
}