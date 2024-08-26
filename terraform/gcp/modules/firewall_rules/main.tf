resource "google_compute_firewall" "firewall" {
  name    = var.firewall_name
  network = var.network

  dynamic "allow" {
    for_each = var.allow_rules
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }

  source_ranges = var.source_ranges
  target_tags   = var.target_tags
}
