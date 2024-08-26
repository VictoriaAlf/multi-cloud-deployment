variable "firewall_name" {
  description = "The name of the firewall rule"
  type        = string
}

variable "network" {
  description = "The network to apply the firewall rule to"
  type        = string
}

variable "allow_rules" {
  description = "List of allow rules for the firewall"
  type = list(object({
    protocol = string
    ports    = list(string)
  }))
  default = []
}

variable "source_ranges" {
  description = "Source IP ranges for the firewall rule"
  type        = list(string)
}

variable "target_tags" {
  description = "Target tags for the firewall rule"
  type        = list(string)
}
