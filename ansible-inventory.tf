terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

resource "random_password" "wordpress_db_password" {
  length = 16
}

resource "random_password" "wordpress_admin_password" {
  length = 16
}

resource "local_sensitive_file" "ansible_inventory" {
  filename = "${path.root}/ansible-inventory.yml"
  content = templatefile(
    "${path.root}/ansible-inventory.template.yml",
    {
      wordpress_public_ip        = module.wordpress.wordpress_public_ip
      wordpress_admin_password   = random_password.wordpress_admin_password.result
      wordpress_db_host          = module.wordpress.wordpress_db_host
      wordpress_db_root_password = module.wordpress.wordpress_db_root_password
      wordpress_db_password      = random_password.wordpress_db_password.result
      wordpress_redis_host       = module.wordpress.wordpress_redis_host
      wordpress_redis_password   = module.wordpress.wordpress_redis_password
    }
  )
}