# Variables for dev environment

variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "tst-devops-intrvw"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-west1"
}

variable "location" {
  description = "GCP location for multi-regional resources"
  type        = string
  default     = "US"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
  default     = "Syke@123"
}

variable "owner_email" {
  description = "Email of the resource owner"
  type        = string
  # This should be provided via terraform.tfvars
}

# Common tags for all resources
variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "terraform-gcp-demo"
    ManagedBy   = "terraform"
  }
}
