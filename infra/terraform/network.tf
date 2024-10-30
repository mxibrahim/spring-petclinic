module "network" {
  source = "./modules/network"
  codename           = var.codename
  project_id         = var.project_id
  project_region     = var.project_region
  subnet_ip_cidr_ranges = {
      "subnet-01" = "10.0.1.0/24",
      "subnet-02" = "10.0.2.0/24"
  }
}
