variable "vpc_name" {
  description = "Nombre de la VPC en GCP"
  type        = string
}

variable "region" {
  description = "Región de GCP donde se creará la VPC"
  type        = string
}

variable "public_subnets" {
  description = "Lista de CIDR para subredes públicas en GCP"
  type        = list(string)
}

variable "private_subnets" {
  description = "Lista de CIDR para subredes privadas en GCP"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the network"
  type        = list(string)
  default     = []
}

variable "k8s_nodes_allow_rules" {
  description = "Allow rules for Kubernetes nodes firewall"
  type = list(object({
    protocol = string
    ports    = list(string)
  }))
  default = []
}

variable "k8s_nodes_source_ranges" {
  description = "Source IP ranges for Kubernetes nodes firewall"
  type        = list(string)
}

variable "k8s_nodes_target_tags" {
  description = "Target tags for Kubernetes nodes firewall"
  type        = list(string)
}

variable "ingress_controller_allow_rules" {
  description = "Allow rules for Ingress Controller firewall"
  type = list(object({
    protocol = string
    ports    = list(string)
  }))
  default = []
}

variable "ingress_controller_source_ranges" {
  description = "Source IP ranges for Ingress Controller firewall"
  type        = list(string)
}

variable "ingress_controller_target_tags" {
  description = "Target tags for Ingress Controller firewall"
  type        = list(string)
}

variable "public_routes" {
  description = "List of routes for public subnets"
  type = list(object({
    name            = string
    dest_range      = string
    priority        = number
    next_hop_gateway = string
  }))
  default = []
}

variable "private_routes" {
  description = "List of routes for private subnets"
  type = list(object({
    name            = string
    dest_range      = string
    priority        = number
    next_hop_gateway = string
  }))
  default = []
}

variable "enable_nat_gateway" {
  description = "Set to true to create a NAT Gateway for private subnets"
  type        = bool
  default     = false
}