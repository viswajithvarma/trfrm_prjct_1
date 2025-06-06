output "function_name" {
  description = "Name of the Cloud Function"
  value       = google_cloudfunctions_function.function.name
}

output "function_url" {
  description = "URL of the Cloud Function"
  value       = google_cloudfunctions_function.function.https_trigger_url
}

output "function_self_link" {
  description = "Self link of the Cloud Function"
  value       = google_cloudfunctions_function.function.self_link
}

output "function_status" {
  description = "Status of the Cloud Function"
  value       = google_cloudfunctions_function.function.status
}

output "function_source_archive_url" {
  description = "Source archive URL of the Cloud Function"
  value       = google_cloudfunctions_function.function.source_archive_url
}
