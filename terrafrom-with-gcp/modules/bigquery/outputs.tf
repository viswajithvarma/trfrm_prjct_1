output "dataset_id" {
  description = "ID of the BigQuery dataset"
  value       = google_bigquery_dataset.dataset.dataset_id
}

output "dataset_self_link" {
  description = "Self link of the BigQuery dataset"
  value       = google_bigquery_dataset.dataset.self_link
}

output "table_id" {
  description = "ID of the BigQuery table"
  value       = google_bigquery_table.table.table_id
}

output "table_self_link" {
  description = "Self link of the BigQuery table"
  value       = google_bigquery_table.table.self_link
}

output "dataset_location" {
  description = "Location of the BigQuery dataset"
  value       = google_bigquery_dataset.dataset.location
}
