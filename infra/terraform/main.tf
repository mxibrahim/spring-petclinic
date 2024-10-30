# main.tf
provider "google" {
  project = var.project_id
  region  = var.project_region
}
