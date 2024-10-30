# # VPC Network > IP Addresses

# resource "google_compute_address" "nat_ip" {
#   name          = "${var.codename}-nat-ip"
#   project       = var.project_id
#   region        = var.project_region
#   address_type  = "EXTERNAL"
#   network_tier  = "PREMIUM"
# }
