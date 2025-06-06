# Cloud Functions module

resource "google_cloudfunctions_function" "function" {
  name                  = var.function_name
  description           = var.description
  runtime               = var.runtime
  available_memory_mb   = var.memory
  timeout               = var.timeout
  entry_point           = var.entry_point
  trigger_http          = var.trigger_http
  https_trigger_security_level = var.https_trigger_security_level
  
  source_archive_bucket = var.source_bucket
  source_archive_object = var.source_object

  environment_variables = var.environment_variables

  dynamic "event_trigger" {
    for_each = var.event_trigger != null ? [var.event_trigger] : []
    content {
      event_type = event_trigger.value.event_type
      resource   = event_trigger.value.resource
      failure_policy {
        retry = event_trigger.value.failure_policy_retry
      }
    }
  }

  labels = var.labels
}

# IAM binding for public access (if needed)
resource "google_cloudfunctions_function_iam_binding" "public_access" {
  count          = var.allow_public_access ? 1 : 0
  project        = var.project_id
  region         = var.region
  cloud_function = google_cloudfunctions_function.function.name
  role           = "roles/cloudfunctions.invoker"
  members        = ["allUsers"]
}
