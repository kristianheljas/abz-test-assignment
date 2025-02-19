module "wordpress" {
  source = "./terraform"
}

output "abz_readonly_console_password" {
  sensitive = true
  value     = module.wordpress.abz_readonly_console_password
}

output "abz_readonly_access_key" {
  value = module.wordpress.abz_readonly_access_key
}

output "abz_readonly_secret_key" {
  sensitive = true
  value     = module.wordpress.abz_readonly_secret_key
}
