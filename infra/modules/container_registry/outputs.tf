output "name" {
  value       = azurerm_container_registry.resource.name
  description = "Specifies the name of the resource."
}

output "id" {
  value       = azurerm_container_registry.resource.id
  description = "Specifies the resource id of the resource."
}

output "admin_password" {
  value       = azurerm_container_registry.resource.admin_password
  description = "Specifies the admin_password of the resource."
}