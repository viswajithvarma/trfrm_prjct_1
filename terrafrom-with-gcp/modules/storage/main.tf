# Storage bucket module for website hosting

resource "google_storage_bucket" "website" {
  name     = var.bucket_name
  location = var.location
  
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
  
  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}

# Make bucket publicly readable
resource "google_storage_bucket_iam_member" "public_access" {
  bucket = google_storage_bucket.website.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

# Upload website files
resource "google_storage_bucket_object" "static_site_src" {
  name   = var.index_file_name
  source = var.index_file_path
  bucket = google_storage_bucket.website.name
  content_type = "text/html"
}

# Upload function source code
resource "google_storage_bucket_object" "function_zip" {
  count  = var.function_zip_path != null ? 1 : 0
  name   = var.function_zip_name
  bucket = google_storage_bucket.website.name
  source = var.function_zip_path
}
