output "function_app_name" {
  description = "The name of the Azure Function App"
  value       = azurerm_function_app.function_app.name
}

output "function_app_default_hostname" {
  description = "The default hostname of the Azure Function App"
  value       = azurerm_function_app.function_app.default_hostname
}
