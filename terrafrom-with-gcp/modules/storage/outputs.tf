output "bucket_name" {
  description = "Name of the created storage bucket"
  value       = google_storage_bucket.website.name
}

output "bucket_url" {
  description = "URL of the storage bucket"
  value       = google_storage_bucket.website.url
}

output "website_url" {
  description = "Website URL for the bucket"
  value       = "https://storage.googleapis.com/${google_storage_bucket.website.name}/${google_storage_bucket_object.static_site_src.name}"
}

output "bucket_self_link" {
  description = "Self link of the storage bucket"
  value       = google_storage_bucket.website.self_link
}
