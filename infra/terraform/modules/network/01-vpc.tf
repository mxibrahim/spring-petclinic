/**
  Network -> VPC
*/

resource "google_compute_network" "main_network" {
  name                            = "${var.codename}-network"
  project                         = "${var.project_id}"
  routing_mode                    = "GLOBAL"
  mtu                             = 1500
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
}
