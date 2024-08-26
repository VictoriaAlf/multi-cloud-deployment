variable "vnet_name" {
  description = "Name of the Azure Virtual Network"
  type        = string
}

variable "location" {
  description = "Azure location where the resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in Azure"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space of the Virtual Network"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Environment tag for Azure resources"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "k8s_nodes_nsg_rules" {
  description = "Security rules for the Kubernetes nodes NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = []
}

variable "ingress_controller_nsg_rules" {
  description = "Security rules for the Ingress Controller NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = []
}

variable "public_routes" {
  description = "List of routes for the public route table"
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = []
}

variable "private_routes" {
  description = "List of routes for the private route table"
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = []
}

variable "enable_nat_gateway" {
  description = "Set to true to create a NAT Gateway for private subnets"
  type        = bool
  default     = false
}