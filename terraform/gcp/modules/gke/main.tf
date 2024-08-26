# GKE Cluster Resource
resource "google_container_cluster" "gke_cluster" {
  name     = var.GCP_cluster_name
  location = var.GCP_region

  network    = var.GCP_network_name
  subnetwork = element(var.GCP_private_subnets, 0)

  initial_node_count = var.GCP_initial_node_count
  min_master_version = var.GCP_master_version

  ip_allocation_policy {}

  node_config {
    machine_type = var.GCP_machine_type
    oauth_scopes = var.GCP_oauth_scopes
  }

  depends_on = [
    var.GCP_network_name,
    var.GCP_private_subnets
  ]
}

# Obtain cluster credentials
resource "null_resource" "get_credentials" {
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${google_container_cluster.gke_cluster.name} --region ${var.GCP_region} --project ${var.GCP_project_id}"
  }

  depends_on = [google_container_cluster.gke_cluster]
}

# Apply ingress controller
resource "null_resource" "deploy_ingress_controller" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/manifests/ingress-controller.yaml"
  }

  depends_on = [null_resource.get_credentials]
}
