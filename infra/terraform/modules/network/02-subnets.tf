/**
  Network -> Subnets
*/

resource "google_compute_subnetwork" "subnet_01" {
  name                     = "${var.codename}-subnet-01"
  ip_cidr_range            = var.subnet_ip_cidr_ranges.subnet-01
  project                  = var.project_id
  region                   = var.project_region
  network                  = google_compute_network.main_network.self_link
  private_ip_google_access = true
  # log_config {
  #   aggregation_interval = "INTERVAL_10_MIN"
  #   flow_sampling        = 0.5
  #   metadata             = "INCLUDE_ALL_METADATA"
  # }
}
