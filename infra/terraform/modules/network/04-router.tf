# /**
#   Network > Cloud Routes
# */

# resource "google_compute_router" "router" {
#   name    = "${var.codename}-router"
#   region  = var.project_region
#   project = var.project_id
#   network = google_compute_network.main_network.self_link
# }
