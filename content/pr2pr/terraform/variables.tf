variable "project_id" {
  description = "The ID of the Google Cloud project to create"
  type        = string
}

variable "region" {
  description = "The region for resources"
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  description = "The zone for resources"
  type        = string
  default     = "europe-west1-b"
}

variable "alloydb_cluster_id" {
  description = "The ID of the AlloyDB cluster"
  type        = string
  default     = "search-cluster"
}

variable "alloydb_instance_id" {
  description = "The ID of the AlloyDB primary instance"
  type        = string
  default     = "search-primary"
}

variable "db_password" {
  description = "The password for the AlloyDB postgres user"
  type        = string
  sensitive   = true
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.0.0/24"
}


