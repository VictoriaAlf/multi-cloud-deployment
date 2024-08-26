variable "resource_group_name" {
  description = "The name of the resource group for the function app"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account for the function app"
  type        = string
}

variable "service_plan_name" {
  description = "The name of the service plan for the function app"
  type        = string
}

variable "function_name" {
  description = "The name of the Azure Function"
  type        = string
}

variable "package_url" {
  description = "The URL of the package to deploy to the Azure Function"
  type        = string
}
