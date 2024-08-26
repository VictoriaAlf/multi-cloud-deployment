output "firewall_id" {
  description = "ID of the firewall rule"
  value       = google_compute_firewall.firewall.id
}
