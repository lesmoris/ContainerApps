output "name" {
  value       = azurerm_postgresql_flexible_server.resource.name
  description = "Specifies the name of the resource."
}

output "id" {
  value       = azurerm_postgresql_flexible_server.resource.id
  description = "Specifies the resource id of the resource."
}