locals {
  resource_name = "server"
}

module "server" {
  source          = "./modules/compute_engine"
  codename        = var.codename
  project_id      = var.project_id
  region          = var.project_region
  zone            = "asia-southeast2-c"
  resource_name   = local.resource_name
  subnetwork      = "${var.codename}-subnet-01"
  network         = "${var.codename}-network"
  external_ip     = true
  # vm_type         = "f1-micro"
  vm_type         = "e2-medium"
  vm_image        = "ubuntu-os-cloud/ubuntu-2004-lts"
  disk_size       = 30
  disk_type       = "pd-standard"
  service_account = "215772839497-compute@developer.gserviceaccount.com" #changeme
  tags            = [var.codename, local.resource_name, "${var.codename}-${local.resource_name}"]
  create_firewall = true

  firewall_content = [
    {
      allow = {
        protocol = "tcp"
        ports    = [
          "22",   # SSH: for Ansible
          "80",   # HTTP
          "443",  # HTTPS
          ]
      }
      priority      = 1000
      source_ranges = ["0.0.0.0/0"]
      target_tags   = ["${var.codename}-${local.resource_name}"]

    },
    # # Example another rule you can create
    # {
    #   deny = {
    #     protocol = "tcp"
    #     ports    = ["80", "443"]
    #   }
    #   priority      = 1
    #   source_ranges = ["0.0.0.0/0"]
    #   target_tags   = ["${var.codename}-${local.resource_name}"]

    # }
  ]


}
