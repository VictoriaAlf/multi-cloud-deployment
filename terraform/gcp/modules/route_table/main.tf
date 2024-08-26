resource "google_compute_route" "route" {
  count       = length(var.routes)
  name        = var.routes[count.index].name
  network     = var.network
  dest_range  = var.routes[count.index].dest_range
  priority    = var.routes[count.index].priority
  next_hop_gateway = var.routes[count.index].next_hop_gateway

  tags        = var.tags
}
