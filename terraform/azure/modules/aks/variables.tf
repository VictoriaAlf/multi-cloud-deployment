
variable "azure_appId" {
  description = "Azure Kubernetes Service Cluster service principal"
  type = string
}

variable "azure_password" {
  description = "Azure Kubernetes Service Cluster password"
  type = string
}

variable "azure_resource_group_name" {
  description = "Name of the Azure Resource Group to create"
  type        = string
}

variable "azure_location" {
  description = "The Azure region where the resources should be created"
  type        = string
  default     = "West US 1"
}

variable "environment" {
  description = "The environment tag for the resources (e.g., Development, Testing, Production)"
  type        = string
}

variable "azure_kubernetes_cluster_name" {
  description = "Name of the Azure Kubernetes Service (AKS) cluster"
  type        = string
}

variable "azure_dns_prefix" {
  description = "DNS prefix to use for the AKS cluster"
  type        = string
}

variable "azure_kubernetes_version" {
  description = "The version of Kubernetes to use for the AKS cluster"
  type        = string
  default     = "1.26.3"
}

variable "azure_node_pool_name" {
  description = "Name of the default node pool in the AKS cluster"
  type        = string
  default     = "default"
}

variable "azure_node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 3
}

variable "azure_vm_size" {
  description = "Size of the Virtual Machines in the default node pool"
  type        = string
  default     = "Standard_D2_v2"
}

variable "azure_os_disk_size_gb" {
  description = "Size of the OS disk in GB for each node in the default node pool"
  type        = number
  default     = 30
}

variable "azure_vnet_subnet_id" {
  description = "Subnet ID of the VNet created in Azure for the AKS cluster"
  type        = string
}

variable "azure_ingress_manifest_path" {
  description = "Path to the Ingress Controller manifest file. Leave empty to skip Ingress deployment."
  type        = string
  default     = ""  # Default to empty string to avoid deploying if not provided
}

