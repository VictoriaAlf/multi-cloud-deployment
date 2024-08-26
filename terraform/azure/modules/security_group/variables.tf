variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "location" {
  description = "Azure location where the NSG will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in Azure"
  type        = string
}

variable "security_rules" {
  description = "List of security rules for the NSG"
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

variable "tags" {
  description = "Tags to apply to the Network Security Group"
  type        = map(string)
  default     = {}
}
