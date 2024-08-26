variable "AWS_region" {
  default     = "us-east-1"
  description = "AWS region"
  type        = string
}

variable "AWS_cluster_name" {
  description = "EKS name"
  type        = string

}

variable "AWS_vpc_name" {
  description = "VPC name"
  type        = string

}

variable "AWS_vpc_cidr_block" {
  default     = "10.0.0.0/16"
  description = "CIDR block to be allocated."
  type        = string
}

variable "AWS_vpc_private_subnets" {
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  description = "CIDR range for private subnets"
  type        = list(string)
}

variable "AWS_vpc_public_subnets" {
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  description = "CIDR range for public subnets"
  type        = list(string)
}


variable "AWS_enable_nat_gateway" {
  description = "Whether to enable NAT Gateway in the VPC"
  type        = bool
  default     = true
}

variable "AWS_single_nat_gateway" {
  description = "Whether to create a single NAT Gateway"
  type        = bool
  default     = true
}

variable "AWS_enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "AWS_cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.27"
}

variable "AWS_cluster_endpoint_public_access" {
  description = "Whether the EKS cluster endpoint should be publicly accessible"
  type        = bool
  default     = true
}

variable "AWS_eks_ami_type" {
  description = "AMI type for the EKS managed node group"
  type        = string
  default     = "AL2_x86_64"
}

variable "AWS_node_group_name" {
  description = "Name of the node group for EKS"
  type        = string
  default     = "default"
}

variable "AWS_instance_types" {
  description = "List of instance types for the EKS managed node group"
  type        = list(string)
  default     = ["t3a.medium"]
}

variable "AWS_node_group_min_size" {
  description = "Minimum size of the EKS node group"
  type        = number
  default     = 1
}

variable "AWS_node_group_max_size" {
  description = "Maximum size of the EKS node group"
  type        = number
  default     = 3
}

variable "AWS_node_group_desired_size" {
  description = "Desired size of the EKS node group"
  type        = number
  default     = 3
}

variable "AWS_cluster_security_group__id" {
  description = "Security group ID"
}

variable "AWS_ingress_manifest_path" {
  description = "Path to the Ingress Controller manifest file. Leave empty to skip Ingress deployment."
  type        = string
  default     = ""  # Default to empty string to avoid deploying if not provided
}

variable "AWS_vpc_id" {
  description = "VPC ID"
}