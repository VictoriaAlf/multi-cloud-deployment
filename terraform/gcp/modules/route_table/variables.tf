variable "network" {
  description = "The network to apply the route to"
  type        = string
}

variable "routes" {
  description = "List of routes to configure"
  type = list(object({
    name            = string
    dest_range      = string
    priority        = number
    next_hop_gateway = string
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to the routes"
  type        = list(string)
  default     = []
}
