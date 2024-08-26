output "vnet_id" {
  description = "ID of the created Virtual Network (VNet) in Azure"
  value       = azurerm_virtual_network.vnet.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = azurerm_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = azurerm_subnet.private[*].id
}

output "k8s_nodes_nsg_id" {
  description = "ID of the Kubernetes nodes NSG"
  value       = module.k8s_nodes_nsg.nsg_id
}

output "ingress_controller_nsg_id" {
  description = "ID of the Ingress Controller NSG"
  value       = module.ingress_controller_nsg.nsg_id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = module.public_route_table.route_table_id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = module.private_route_table.route_table_id
}
