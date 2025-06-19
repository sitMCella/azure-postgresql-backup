output "container_registry_name" {
  description = "The name of the Container Registry"
  value       = azurerm_container_registry.container_registry.name
}

output "container_registry_login_server" {
  description = "The login server of the Container Registry"
  value       = azurerm_container_registry.container_registry.login_server
}
