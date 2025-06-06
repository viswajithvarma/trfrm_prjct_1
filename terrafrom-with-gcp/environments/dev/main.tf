# Main configuration for dev environment using modules

# Storage module for website hosting
module "storage" {
  source = "../../modules/storage"
  
  bucket_name       = "exmpl-tst-devops-intrvw-wbst-${var.environment}"
  location          = var.location
  index_file_path   = "../../website/index.html"
  function_zip_path = "../../infra/function-code.zip"
}

# Database module for PostgreSQL
module "database" {
  source = "../../modules/database"
  
  instance_name    = "test-tf-sql-instnc-${var.environment}"
  database_version = "POSTGRES_13"
  region           = var.region
  database_name    = "test_tf_db"
  user_name        = "admin"
  user_password    = var.db_password
  
  authorized_networks = [
    {
      name  = "allow-all"
      value = "0.0.0.0/0"
    }
  ]
}

# BigQuery module
module "bigquery" {
  source = "../../modules/bigquery"
  
  dataset_id    = "test_tf_dataset_${var.environment}"
  location      = var.location
  owner_email   = var.owner_email
  table_id      = "sample_table"
  
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

# Compute module for Dataproc
module "compute" {
  source = "../../modules/compute"
  
  cluster_name = "tst-dvps-dataproc-${var.environment}"
  region       = var.region
}

# Cloud Functions module
module "functions" {
  source = "../../modules/functions"
  
  function_name           = "tst-tf-function-${var.environment}"
  description            = "Terraform Deployed Cloud Function for ${var.environment}"
  entry_point            = "Hello_world"
  source_bucket          = module.storage.bucket_name
  source_object          = "function-code.zip"
  project_id             = var.project_id
  region                 = var.region
  allow_public_access    = true
  
  depends_on = [module.storage]
}
