
resource "google_compute_network" "default" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}


resource "google_compute_subnetwork" "public" {
  count = length(var.public_subnets)

  name          = "${var.vpc_name}-public-${count.index}"
  ip_cidr_range = var.public_subnets[count.index]
  region        = var.region
  network       = google_compute_network.default.name
}

resource "google_compute_subnetwork" "private" {
  count = length(var.private_subnets)

  name          = "${var.vpc_name}-private-${count.index}"
  ip_cidr_range = var.private_subnets[count.index]
  region        = var.region
  network       = google_compute_network.default.name
}

# Cloud Router for NAT
resource "google_compute_router" "nat_router" {
  count = var.enable_nat_gateway ? 1 : 0
  name    = "${var.vpc_name}-nat-router"
  network = google_compute_network.default.name
  region  = var.region
}

resource "google_compute_router_nat" "nat_gateway" {
  count = var.enable_nat_gateway ? 1 : 0
  name                                 = "${var.vpc_name}-nat-gateway"
  router                               = google_compute_router.nat_router.name
  region                               = var.region
  nat_ip_allocate_option               = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat   = "LIST_OF_SUBNETWORKS"
  
  subnetwork {
    name                    = google_compute_subnetwork.private[*].name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

# Firewall Rules for Kubernetes Nodes
module "k8s_nodes_firewall" {
  source         = "../firewall_rules"
  firewall_name  = "${var.vpc_name}-k8s-nodes-fw"
  network        = google_compute_network.default.name
  allow_rules    = var.k8s_nodes_allow_rules
  source_ranges  = var.k8s_nodes_source_ranges
  target_tags    = var.k8s_nodes_target_tags
}

# Firewall Rules for Ingress Controller
module "ingress_controller_firewall" {
  source         = "../firewall_rules"
  firewall_name  = "${var.vpc_name}-ingress-controller-fw"
  network        = google_compute_network.default.name
  allow_rules    = var.ingress_controller_allow_rules
  source_ranges  = var.ingress_controller_source_ranges
  target_tags    = var.ingress_controller_target_tags
}

# Routes for the Network
module "public_routes" {
  source       = "../route_table"
  network      = google_compute_network.default.name
  routes       = var.public_routes
  tags         = var.tags
}

