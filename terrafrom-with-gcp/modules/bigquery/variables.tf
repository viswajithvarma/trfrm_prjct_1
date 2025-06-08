variable "dataset_id" {
  description = "ID of the BigQuery dataset"
  type        = string
}

variable "location" {
  description = "Location for the BigQuery dataset"
  type        = string
  default     = "US"
}

variable "description" {
  description = "Description of the BigQuery dataset"
  type        = string
  default     = "Terraform managed BigQuery dataset"
}

variable "owner_email" {
  description = "Email of the dataset owner"
  type        = string
}

variable "reader_domain" {
  description = "Domain with reader access"
  type        = string
  default     = "varma.jittu@gmail.com"
}

variable "default_table_expiration_ms" {
  description = "Default table expiration in milliseconds"
  type        = number
  default     = null
}

variable "table_id" {
  description = "ID of the BigQuery table"
  type        = string
}

variable "partition_type" {
  description = "Partitioning type"
  type        = string
  default     = "DAY"
}

variable "partition_field" {
  description = "Field to partition by"
  type        = string
  default     = null
}

variable "schema" {
  description = "Schema for the BigQuery table"
  type        = string
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}
