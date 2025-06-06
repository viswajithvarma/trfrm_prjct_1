# BigQuery dataset and table module

resource "google_bigquery_dataset" "dataset" {
  dataset_id  = var.dataset_id
  location    = var.location
  description = var.description

  access {
    role          = "OWNER"
    user_by_email = var.owner_email
  }

  access {
    role   = "READER"
    domain = var.reader_domain
  }

  default_table_expiration_ms = var.default_table_expiration_ms
}

resource "google_bigquery_table" "table" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = var.table_id

  time_partitioning {
    type  = var.partition_type
    field = var.partition_field
  }

  schema = var.schema

  deletion_protection = var.deletion_protection
}
