# AWS Provider Configuration
provider "aws" {
  region = var.AWS_region
}

# Get AWS Availability Zones
data "aws_availability_zones" "available" {}

# AWS EKS Module
module "eks" {
  source                     = "terraform-aws-modules/eks/aws"
  version                    = "19.15.3"
  cluster_name               = var.AWS_cluster_name
  cluster_version            = var.AWS_cluster_version
  vpc_id                     = var.AWS_vpc_id
  subnet_ids                 = var.AWS_vpc_private_subnets
  cluster_endpoint_public_access = var.AWS_cluster_endpoint_public_access
  cluster_security_group_id  = var.AWS_cluster_security_group__id

  eks_managed_node_group_defaults = {
    ami_type = var.AWS_eks_ami_type
  }

  eks_managed_node_groups = {
    default = {
      name           = var.AWS_node_group_name
      instance_types = var.AWS_instance_types
      min_size       = var.AWS_node_group_min_size
      max_size       = var.AWS_node_group_max_size
      desired_size   = var.AWS_node_group_desired_size
    }
  }
}

# Obtain EKS cluster credentials
resource "null_resource" "get_eks_credentials" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region ${var.AWS_region} --name ${var.AWS_cluster_name}"
  }

  depends_on = [module.eks]
}

# Deploy Ingress Controller only if the ingress manifest path is provided
resource "null_resource" "deploy_ingress_controller" {
  count = var.AWS_ingress_manifest_path != "" ? 1 : 0  # Only create this resource if the path is provided

  provisioner "local-exec" {
    command = "kubectl apply -f ${var.AWS_ingress_manifest_path}"
  }

  depends_on = [null_resource.get_eks_credentials]
}
