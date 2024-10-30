# /**
#   Network > Cloud NAT
# */

# resource "google_compute_router_nat" "main_firewall_nat" {
#   name                               = "${var.codename}-nat"
#   router                             = google_compute_router.router.name
#   project                            = var.project_id
#   region                             = var.project_region
# #   nat_ip_allocate_option             = "AUTO_ONLY"
#   nat_ip_allocate_option             = "MANUAL_ONLY"
#   nat_ips                            = google_compute_address.nat_ip.*.self_link
#   source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

#   # log_config {
#   #   enable = true
#   #   filter = "ERRORS_ONLY"
#   # }
# }
