variable "cluster_name" {
  description = "Name of the Dataproc cluster"
  type        = string
}

variable "region" {
  description = "Region for the Dataproc cluster"
  type        = string
}

variable "master_num_instances" {
  description = "Number of master instances"
  type        = number
  default     = 1
}

variable "master_machine_type" {
  description = "Machine type for master nodes"
  type        = string
  default     = "n1-standard-2"
}

variable "worker_num_instances" {
  description = "Number of worker instances"
  type        = number
  default     = 2
}

variable "worker_machine_type" {
  description = "Machine type for worker nodes"
  type        = string
  default     = "n1-standard-2"
}

variable "preemptible_num_instances" {
  description = "Number of preemptible instances"
  type        = number
  default     = 0
}

variable "boot_disk_type" {
  description = "Boot disk type"
  type        = string
  default     = "pd-standard"
}

variable "boot_disk_size_gb" {
  description = "Boot disk size in GB"
  type        = number
  default     = 30
}

variable "image_version" {
  description = "Dataproc image version"
  type        = string
  default     = "2.0-debian10"
}

variable "override_properties" {
  description = "Override properties for Dataproc cluster"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Network tags for the cluster"
  type        = list(string)
  default     = []
}

variable "enable_shielded_vm" {
  description = "Enable shielded VM"
  type        = bool
  default     = true
}
