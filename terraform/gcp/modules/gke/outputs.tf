output "GCP_cluster_name" {
  description = "Name of the GKE cluster created in GCP"
  value       = google_container_cluster.gke_cluster.name
}

output "GCP_cluster_endpoint" {
  description = "Endpoint of the GKE cluster"
  value       = google_container_cluster.gke_cluster.endpoint
}

output "GCP_cluster_ca_certificate" {
  description = "CA certificate of the GKE cluster"
  value       = google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate
}
