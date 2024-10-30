variable "codename" {
  description = "Project Codename"
  type        = string
}

variable "project_region" {
  description = "The GCP region to use."
  type        = string
	default = "asia-southeast2-a"
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs to."
  type        = string
  default     = null
}

variable "resource_name" {
  description = "name of the compute engine"
  type        = string
}

variable "subnetwork" {
  description = "name of the subnetwork"
  type        = string
}

variable "region" {
  default = "asia-southeast2"
}
variable "zone" {
  default = "asia-southeast2-a"
}
variable "vm_name" {
  default = "kafka-prod-master"
}

variable "vm_type" {
  default = "f1-micro"
}

variable "disk_size" {
  type = number
  default = 20
}

variable "vm_image" {
  default = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "disk_type" {
  default = "pd-standard"
}


variable "metadata_script" {
  default = null
}

variable "tags" {
	type = list(string)
	default = []
}


variable "external_ip" {
  description = "Attach External IP Address to the instance"
  type        = bool
  default     = false
}

variable "service_account" {
  description = "Service account attached to the instance"
}

variable "network" {
  description = "Name of the VPC Network"
  type = string
}

variable "create_firewall" {
  description = "Whether to create the firewall rule"
  type        = bool
  default     = false
}

variable "firewall_content" {
  description = "List of firewall rules configurations"
  type = list(object({
    allow = object({
      protocol     = string
      ports        = list(string)
    })
    priority      = number
    source_ranges = list(string)
    target_tags   = list(string)

  }))
  default = []
}
