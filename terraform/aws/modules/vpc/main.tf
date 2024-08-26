provider "aws" {
  region = var.AWS_region
}

# Define AWS VPC
resource "aws_vpc" "main" {
  cidr_block           = var.AWS_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.AWS_vpc_name}"
  }
}

# Define Public Subnets
resource "aws_subnet" "public" {
  count                   = length(var.AWS_public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.AWS_public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "${var.AWS_vpc_name}-public-${count.index}"
    environment = var.AWS_environment
  }
}

# Define Private Subnets
resource "aws_subnet" "private" {
  count             = length(var.AWS_private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.AWS_private_subnet_cidrs[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "${var.AWS_vpc_name}-private-${count.index}"
  }
}

# Internet Gateway for public subnets
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.AWS_vpc_name}-igw"
  }
}

# Conditional creation of NAT Gateway resources
resource "aws_eip" "nat" {
  count = var.AWS_enable_nat_gateway ? 1 : 0
  vpc   = true
}

resource "aws_nat_gateway" "main" {
  count         = var.AWS_enable_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public[0].id  # Place NAT in the first public subnet

  tags = {
    Name = "${var.AWS_vpc_name}-nat"
  }
}

# Security Groups

module "k8s_nodes_sg" {
  source      = "../security_group"
  name_prefix = "${var.AWS_vpc_name}-k8s-nodes"
  vpc_id      = aws_vpc.main.id
  description = "Security group for Kubernetes nodes"

  ingress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [aws_vpc.main.cidr_block]
      description = "Allow all internal traffic within the VPC"
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]

  tags = {
    Name = "${var.AWS_vpc_name}-k8s-nodes-sg"
  }
}

module "ingress_controller_sg" {
  source      = "../security_group"
  name_prefix = "${var.AWS_vpc_name}-ingress-controller"
  vpc_id      = aws_vpc.main.id
  description = "Security group for Ingress Controller"

  ingress_rules = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = concat(var.GCP_allowed_ip_ranges, var.azure_allowed_ip_ranges)
      description = "Allow HTTPS from trusted IP ranges"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = concat(var.GCP_allowed_ip_ranges, var.azure_allowed_ip_ranges)
      description = "Allow HTTP from trusted IP ranges"
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]

  tags = {
    Name = "${var.AWS_vpc_name}-ingress-sg"
  }
}

# Route Tables

module "public_route_table" {
  source       = "../route_table"
  vpc_id       = aws_vpc.main.id
  subnet_ids   = aws_subnet.public[*].id
  routes = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.main.id
    }
  ]
  tags = {
    Name = "${var.AWS_vpc_name}-public-rt"
  }
}

# Conditionally create private route table routes based on NAT Gateway
module "private_route_table" {
  source       = "../route_table"
  vpc_id       = aws_vpc.main.id
  subnet_ids   = aws_subnet.private[*].id
  routes = var.AWS_enable_nat_gateway ? [
    {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.main[0].id
    }
  ] : []
  tags = {
    Name = "${var.AWS_vpc_name}-private-rt"
  }
}
