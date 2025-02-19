
resource "random_password" "wordpress_redis" {
  length  = 16
  special = false
}

resource "aws_elasticache_subnet_group" "wordpress" {
  name       = "wordpress"
  subnet_ids = values(aws_subnet.wordpress)[*].id
}

resource "aws_elasticache_replication_group" "wordpress" {
  replication_group_id       = "wordpress"
  description                = "Wordpress"
  engine                     = "redis"
  node_type                  = var.elasticache_instance_type
  num_cache_clusters         = 1
  parameter_group_name       = "default.redis7"
  engine_version             = "7.1"
  port                       = 6379
  subnet_group_name          = aws_elasticache_subnet_group.wordpress.name
  transit_encryption_enabled = true
  auth_token                 = random_password.wordpress_redis.result
}

output "wordpress_redis_host" {
  value = aws_elasticache_replication_group.wordpress.primary_endpoint_address
}

output "wordpress_redis_password" {
  value = random_password.wordpress_redis.result
}
