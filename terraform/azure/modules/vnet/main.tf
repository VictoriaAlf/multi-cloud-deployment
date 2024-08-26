# Create a Virtual Network (VNet) in Azure
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_address_space]

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "public" {
count                = length(var.public_subnet_cidrs)
  name                 = "${var.vnet_name}-public-${count.index}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.public_subnet_cidrs[count.index]]

}


resource "azurerm_subnet" "private" {
  count                = length(var.private_subnet_cidrs)
  name                 = "${var.vnet_name}-private-${count.index}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.private_subnet_cidrs[count.index]]
}

# Create Public IP for NAT Gateway
resource "azurerm_public_ip" "nat_gateway_ip" {
  count               = var.enable_nat_gateway ? 1 : 0
  name                = "${var.vnet_name}-nat-gw-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create NAT Gateway
resource "azurerm_nat_gateway" "nat_gateway" {
  count               = var.enable_nat_gateway ? 1 : 0
  name                = "${var.vnet_name}-nat-gateway"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"

  lifecycle {
    create_before_destroy = true
  }
}

# Associate NAT Gateway with Private Subnets
resource "azurerm_subnet_nat_gateway_association" "private" {
  count                 = var.enable_nat_gateway ? length(azurerm_subnet.private) : 0
  subnet_id             = element(azurerm_subnet.private[*].id, count.index)
  nat_gateway_id        = azurerm_nat_gateway.nat_gateway[0].id
}

# Network Security Groups (NSGs) Module for Kubernetes Nodes
module "k8s_nodes_nsg" {
  source                = "../security_group"
  nsg_name              = "${var.vnet_name}-k8s-nodes-nsg"
  location              = var.location
  resource_group_name   = var.resource_group_name
  security_rules        = var.k8s_nodes_nsg_rules
  tags                  = var.tags
}

# Network Security Groups (NSGs) Module for Ingress Controller
module "ingress_controller_nsg" {
  source                = "../security_group"
  nsg_name              = "${var.vnet_name}-ingress-controller-nsg"
  location              = var.location
  resource_group_name   = var.resource_group_name
  security_rules        = var.ingress_controller_nsg_rules
  tags                  = var.tags
}

# Route Table for Public Subnets
module "public_route_table" {
  source                = "../route_table"
  route_table_name      = "${var.vnet_name}-public-rt"
  location              = var.location
  resource_group_name   = var.resource_group_name
  routes                = var.public_routes
  subnet_ids            = azurerm_subnet.public[*].id
  tags                  = var.tags
}

# Route Table for Private Subnets (no NAT gateway in this setup)
module "private_route_table" {
  source                = "../route_table"
  route_table_name      = "${var.vnet_name}-private-rt"
  location              = var.location
  resource_group_name   = var.resource_group_name
  routes                = var.private_routes
  subnet_ids            = azurerm_subnet.private[*].id
  tags                  = var.tags
}
