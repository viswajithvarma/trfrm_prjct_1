# most of our terraform code will go here on Main.tf

# bucket to store website


resource "google_storage_bucket" "website" {
  name     = "exmpl-tst-devops-intrvw-wbst"
  location = "US"
}

# make new objects public

resource "google_storage_object_access_control" "public_rule" {
  object = google_storage_bucket_object.static_site_src.name
  bucket = google_storage_bucket.website.name
  role   = "READER"
  entity = "allUsers"

}

# upload the html file to the bucket upload it from the local storage to the bucket and items in the bucket are called objects

resource "google_storage_bucket_object" "static_site_src" {
  name   = "index.html"
  source = "../website/index.html"
  bucket = google_storage_bucket.website.name

}

# reserve a static external IP address 

# setup a cloud SQL with postgres 

resource "google_sql_database_instance" "default" {

  name                = "test-tf-sql-instnc"
  database_version    = "postgres_13"
  region              = var.gcp_region
  deletion_protection = false

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "users" {
  name     = "admin"
  instance = google_sql_database_instance.default.name
  password = "Syke@123"

}

resource "google_sql_database" "default" {
  name     = "test_tf_db"
  instance = google_sql_database_instance.default.name
}

# setup a bigquery dataset and a table 

resource "google_bigquery_dataset" "dataset" {

  dataset_id = "test_tf_dataset"
  location   = var.gcp_location

}

resource "google_bigquery_table" "table" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "sample_table"


  schema = jsonencode([
    {
      name = "id"
      type = "STRING"
      mode = "REQUIRED"
    },

    {
      name = "timestamp"
      type = "TIMESTAMP"
      mode = "NULLABLE"
    }
  ])

}

resource "google_dataproc_cluster" "default" {
  name   = "tst-dvps-dataproc"
  region = var.gcp_region

  cluster_config {
    master_config {
      num_instances = 1
      machine_type  = "n1-standard-2"
    }

    worker_config {
      num_instances = 2
      machine_type  = "n1-standard-2"
    }
  }

}

resource "google_storage_bucket_object" "zip" {
  name   = "function-code.zip"
  bucket = google_storage_bucket.website.name
  source = "function-code.zip"

}

resource "google_cloudfunctions_function" "example" {
  name                  = "tst-tf-function"
  description           = "Terraform Deployed Cloud Function"
  runtime               = "python39"
  entry_point           = "hello_world"
  trigger_http          = true
  source_archive_bucket = google_storage_bucket.website.name
  source_archive_object = google_storage_bucket_object.zip.name

}