variable "GCP_project_id" {
  description = "The GCP project ID where the GKE cluster will be created"
  type        = string
}

variable "GCP_region" {
  description = "The region in GCP where the GKE cluster will be created"
  type        = string
  default     = "us-central1"  # Default to a commonly used region
}

variable "GCP_cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "GCP_network_name" {
  description = "The name of the VPC network in GCP"
  type        = string
}

variable "GCP_private_subnets" {
  description = "List of private subnets in the VPC network"
  type        = list(string)
}

variable "GCP_initial_node_count" {
  description = "Initial number of nodes in the GKE cluster"
  type        = number
  default     = 1
}

variable "GCP_master_version" {
  description = "Kubernetes version for the GKE master node"
  type        = string
  default     = "1.26.3"
}

variable "GCP_machine_type" {
  description = "Machine type for the GKE cluster nodes"
  type        = string
  default     = "e2-medium"  # Default to a commonly used machine type
}

variable "GCP_oauth_scopes" {
  description = "OAuth scopes to be used by the nodes in the GKE cluster"
  type        = list(string)
  default     = [
    "https://www.googleapis.com/auth/cloud-platform"
  ]
}
