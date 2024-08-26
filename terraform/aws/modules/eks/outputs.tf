
output "AWS_eks_cluster_id" {
  description = "EKS cluster ID."
  value       = module.eks.cluster_id
}

output "AWS_region" {
  description = "AWS region"
  value       = var.AWS_region
}

output "AWS_eks_cluster_name" {
  description = "Name of the created EKS cluster in AWS"
  value       = module.eks.cluster_name
}

output "AWS_eks_cluster_endpoint" {
  description = "Endpoint of the created EKS cluster in AWS"
  value       = module.eks.cluster_endpoint
}


output "AWS_public_subnets" {
  description = "List of public subnet IDs in the created VPC"
  value = try(module.vpc.aws_subnet.public_subnet[*].id, null)
}

output "AWS_private_subnets" {
  description = "List of private subnet IDs in the created VPC"
  value = try(module.vpc.aws_subnet.private_subnet[*].id, null)
}

output "AWS_vpc_id" {
  description = "ID of the created VPC in AWS"
  value       = try(module.vpc.id, null)
}

