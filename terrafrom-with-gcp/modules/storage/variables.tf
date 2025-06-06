variable "bucket_name" {
  description = "Name of the storage bucket"
  type        = string
}

variable "location" {
  description = "Location for the storage bucket"
  type        = string
  default     = "US"
}

variable "index_file_name" {
  description = "Name of the index file in the bucket"
  type        = string
  default     = "index.html"
}

variable "index_file_path" {
  description = "Local path to the index file"
  type        = string
}

variable "function_zip_name" {
  description = "Name of the function zip file in the bucket"
  type        = string
  default     = "function-code.zip"
}

variable "function_zip_path" {
  description = "Local path to the function zip file"
  type        = string
  default     = null
}
