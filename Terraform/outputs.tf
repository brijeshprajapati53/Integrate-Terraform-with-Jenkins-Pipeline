output "resource_group_name" {
  value = azurerm_resource_group.this.name
}

output "service_plan_id" {
  value = azurerm_service_plan.this.id
}

output "app_service_url" {
  description = "The default hostname of the App Service"
  value       = azurerm_linux_web_app.this.default_hostname
}