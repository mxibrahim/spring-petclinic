variable "codename" {
  description = "Project Codename"
  type        = string
}

variable "project_id" {
  description = "Google Cloud Platform Project ID"
  type        = string
}

variable "project_region" {
  description = "Google Cloud Platform Project Region"
  type        = string
}

variable "subnet_ip_cidr_ranges" {
  description = "Subnet IP CIDR Ranges"
  type        = map(any)
}
