# Outputs for dev environment

# Storage outputs
output "website_bucket_name" {
  description = "Name of the website storage bucket"
  value       = module.storage.bucket_name
}

output "website_url" {
  description = "URL of the static website"
  value       = module.storage.website_url
}

# Database outputs
output "database_connection_name" {
  description = "Cloud SQL connection name"
  value       = module.database.instance_connection_name
}

output "database_public_ip" {
  description = "Database public IP address"
  value       = module.database.instance_public_ip_address
}

# BigQuery outputs
output "bigquery_dataset_id" {
  description = "BigQuery dataset ID"
  value       = module.bigquery.dataset_id
}

output "bigquery_table_id" {
  description = "BigQuery table ID"
  value       = module.bigquery.table_id
}

# Compute outputs
output "dataproc_cluster_name" {
  description = "Dataproc cluster name"
  value       = module.compute.cluster_name
}

output "dataproc_master_instances" {
  description = "Dataproc master instance names"
  value       = module.compute.master_instance_names
}

# Functions outputs
output "cloud_function_name" {
  description = "Cloud Function name"
  value       = module.functions.function_name
}

output "cloud_function_url" {
  description = "Cloud Function trigger URL"
  value       = module.functions.function_url
}

# Summary output for CI/CD reference
output "deployment_summary" {
  description = "Summary of deployed resources"
  value = {
    environment     = var.environment
    project_id      = var.project_id
    region          = var.region
    website_url     = module.storage.website_url
    function_url    = module.functions.function_url
    database_ip     = module.database.instance_public_ip_address
    dataproc_cluster = module.compute.cluster_name
  }
}
