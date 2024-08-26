output "AWS_vpc_id" {
  description = "The ID of the VPC"
  value       = try(aws_vpc.main.id, null)
}

output "AWS_vpc_subnet_public" {
  value = try(aws_subnet.public.id, null)
}

output "AWS_vpc_subnet_private" {
  value = try(aws_subnet.private.id, null)
}

output "AWS_k8s_nodes_sg" {
  description = "ID of the security group for k8s nodes"
  value       = module.k8s_nodes_sg.output.AWS_sg_id
}

output "AWS_ingress_controller_sg" {
  description = "ID of the security group for ingress controller"
  value       = module.ingress_controller_sg.output.AWS_sg_id
}