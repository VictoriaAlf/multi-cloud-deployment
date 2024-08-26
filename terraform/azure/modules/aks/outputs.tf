output "kubernetes_cluster_name" {
  description = "Name of the Kubernetes cluster in Azure"
  value       = azurerm_kubernetes_cluster.default.name
}

output "kubernetes_cluster_id" {
  description = "ID of the Kubernetes cluster in Azure"
  value       = azurerm_kubernetes_cluster.default.id
}
