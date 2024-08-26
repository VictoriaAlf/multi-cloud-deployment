variable "route_table_name" {
  description = "Name of the route table"
  type        = string
}

variable "location" {
  description = "Azure location where the route table will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in Azure"
  type        = string
}

variable "routes" {
  description = "List of routes to configure in the route table"
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = []
}

variable "subnet_ids" {
  description = "List of Subnet IDs to associate with the route table"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the route table"
  type        = map(string)
  default     = {}
}
