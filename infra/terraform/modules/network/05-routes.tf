/**
  Network > Routes
*/

# Egress internet
resource "google_compute_route" "main_route_egress_internet" {
  name             = "${var.codename}-route-egress-internet"
  project          = var.project_id
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.main_network.id
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}
