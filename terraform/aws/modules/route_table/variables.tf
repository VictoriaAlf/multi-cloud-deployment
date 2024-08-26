variable "vpc_id" {
  description = "The VPC ID to associate the route table with"
  type        = string
}

variable "subnet_ids" {
  description = "List of Subnet IDs to associate the route table with"
  type        = list(string)
}

variable "routes" {
  description = "List of routes to configure in the route table"
  type = list(object({
    cidr_block                     = string
    gateway_id                     = optional(string)
    nat_gateway_id                 = optional(string)
    egress_only_gateway_id         = optional(string)
    transit_gateway_id             = optional(string)
    vpc_peering_connection_id      = optional(string)
    network_interface_id           = optional(string)
    destination_prefix_list_id     = optional(string)
    carrier_gateway_id             = optional(string)
  }))
  default = []
}

variable "tags" {
  description = "Tags to assign to the route table"
  type        = map(string)
  default     = {}
}
