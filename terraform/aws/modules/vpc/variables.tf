variable "AWS_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-west-2"
}

variable "AWS_vpc_name" {
  description = "Name of the VPC to be created in AWS"
  type        = string
  default     = "my-vpc"
}

variable "AWS_vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "AWS_public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "AWS_private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "GCP_allowed_ip_ranges" {
  description = "List of allowed IP ranges from GCP"
  type        = list(string)
  default     = []
}

variable "azure_allowed_ip_ranges" {
  description = "List of allowed IP ranges from Azure"
  type        = list(string)
  default     = []
}

variable "AWS_enable_nat_gateway" {
  description = "Set to true to create a NAT Gateway for private subnets"
  type        = bool
  default     = false
}

variable "AWS_environment" {
  description = "Environment"
  type = string
}

