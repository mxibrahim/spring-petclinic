provider "google" {
  project = "${var.project_id}"
  region  = var.region
  zone    = var.zone
}

resource "google_compute_address" "internal" {
  name         = "ipv4-internal-${var.resource_name}"
  address_type = "INTERNAL"
  region       = var.region
  subnetwork   = "${var.subnetwork}"
}

resource "google_compute_address" "external" {
  count        = var.external_ip == true ? 1 : 0
  name         = "ipv4-external-${var.resource_name}"
  address_type = "EXTERNAL"
  region       = var.region
}

resource "google_compute_instance" "default" {
  name         = "${var.codename}-${var.resource_name}"
  machine_type = var.vm_type

  allow_stopping_for_update = true

  service_account {
    email = var.service_account
    scopes = ["cloud-platform"]
  }

  boot_disk {    
    initialize_params {
      image = var.vm_image
      type  = var.disk_type
      size  = var.disk_size
    }
  }

  network_interface {
    network    = "${var.codename}-network"
    subnetwork = "${var.subnetwork}"
    network_ip = google_compute_address.internal.address

    # Assign external IP if var.external_ip = true
    dynamic "access_config" {
      for_each = var.external_ip ? [1] : []
      content {
        nat_ip = google_compute_address.external[0].address
      }
    }
  }

  tags = var.tags

}

resource "google_compute_firewall" "firewall" {
  count   = var.create_firewall ? length(var.firewall_content) : 0
  name    = "${var.codename}-${var.resource_name}-firewall-${count.index}"
  project = var.project_id
  network = var.network

  allow {
    protocol     = var.firewall_content[count.index].allow.protocol
    ports        = var.firewall_content[count.index].allow.ports
  }

  source_ranges = var.firewall_content[count.index].source_ranges
  target_tags   = var.firewall_content[count.index].target_tags
  priority      = var.firewall_content[count.index].priority

}
