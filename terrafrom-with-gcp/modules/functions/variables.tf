variable "function_name" {
  description = "Name of the Cloud Function"
  type        = string
}

variable "description" {
  description = "Description of the Cloud Function"
  type        = string
  default     = "Terraform managed Cloud Function"
}

variable "runtime" {
  description = "Runtime for the Cloud Function"
  type        = string
  default     = "python39"
}

variable "memory" {
  description = "Memory allocation for the function"
  type        = number
  default     = 256
}

variable "timeout" {
  description = "Timeout for the function in seconds"
  type        = number
  default     = 60
}

variable "entry_point" {
  description = "Entry point for the function"
  type        = string
}

variable "trigger_http" {
  description = "Enable HTTP trigger"
  type        = bool
  default     = true
}

variable "https_trigger_security_level" {
  description = "Security level for HTTPS trigger"
  type        = string
  default     = "SECURE_OPTIONAL"
}

variable "source_bucket" {
  description = "GCS bucket containing the source code"
  type        = string
}

variable "source_object" {
  description = "GCS object containing the source code"
  type        = string
}

variable "environment_variables" {
  description = "Environment variables for the function"
  type        = map(string)
  default     = {}
}

variable "event_trigger" {
  description = "Event trigger configuration"
  type = object({
    event_type             = string
    resource               = string
    failure_policy_retry   = bool
  })
  default = null
}

variable "labels" {
  description = "Labels for the function"
  type        = map(string)
  default     = {}
}

variable "allow_public_access" {
  description = "Allow public access to the function"
  type        = bool
  default     = false
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}
