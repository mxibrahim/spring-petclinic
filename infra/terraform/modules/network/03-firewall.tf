# /**
#   Network -> Firewall
# */

# Allow SSH
resource "google_compute_firewall" "main_firewall_allow_ssh" {
  name    = "${var.codename}-allow-ssh"
  project = var.project_id
  network = google_compute_network.main_network.id
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  priority      = 65534
  source_ranges = [
    "${var.subnet_ip_cidr_ranges.subnet-01}", # Local Address
    "35.235.240.0/20" # Allow SSH via IAP
  ]
}

resource "google_compute_firewall" "main_firewall_allow_icmp" {
  name    = "${var.codename}-allow-icmp"
  project = var.project_id
  network = google_compute_network.main_network.id
  allow {
    protocol = "icmp"
  }
  priority      = 65534
  source_ranges = ["0.0.0.0/0"]
}

# Allow Health Check
resource "google_compute_firewall" "main_firewall_allow_health_check" {
  name    = "${var.codename}-allow-health-check"
  project = var.project_id
  network = google_compute_network.main_network.id
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  priority      = 65534
  source_ranges = ["35.191.0.0/16", "209.85.152.0/22", "209.85.204.0/22"]
}


# Allow All Local
resource "google_compute_firewall" "main_firewall_allow_all_local" {
  name    = "${var.codename}-allow-local"
  project = var.project_id
  network = google_compute_network.main_network.id
  allow {
    protocol = "all"
  }

  priority      = 65534
  source_ranges = ["${var.subnet_ip_cidr_ranges.subnet-01}"]
}

# Allow All Egress
resource "google_compute_firewall" "main_firewall_allow_all_egress" {
  name    = "${var.codename}-allow-all-egress"
  project = var.project_id
  network = google_compute_network.main_network.id
  allow {
    protocol = "all"
  }
  direction = "EGRESS"
  priority      = 65535
  destination_ranges = ["0.0.0.0/0"]
}


# Deny All Ingress
resource "google_compute_firewall" "main_firewall_deny_all_ingress" {
  name    = "${var.codename}-deny-all-ingress"
  project = var.project_id
  network = google_compute_network.main_network.id
  deny {
    protocol = "all"
  }
  priority      = 65535
  source_ranges = ["0.0.0.0/0"]
}