output "acr_admin_password" {
  value     = module.container_registry.admin_password
  sensitive = true
}
