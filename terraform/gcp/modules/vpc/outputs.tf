output "vpc_network_name" {
  description = "Nombre de la VPC creada"
  value       = google_compute_network.default.name
}

output "public_subnets" {
  description = "Subredes públicas creadas en la VPC"
  value       = google_compute_subnetwork.public[*].name
}

output "private_subnets" {
  description = "Subredes privadas creadas en la VPC"
  value       = google_compute_subnetwork.private[*].name
}

output "k8s_nodes_firewall_id" {
  description = "ID of the Kubernetes nodes firewall"
  value       = module.k8s_nodes_firewall.firewall_id
}

output "ingress_controller_firewall_id" {
  description = "ID of the Ingress Controller firewall"
  value       = module.ingress_controller_firewall.firewall_id
}
