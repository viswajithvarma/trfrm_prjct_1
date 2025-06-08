# we need to pull the provider GCP from terraform registery 

# GCP Provider

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.15.0" # Or the desired version
    }
  }

  required_version = ">= 1.12.1"
}


provider "google" {

  credentials = file(var.gcp_svc_key)
  project     = var.gcp_project
  region      = var.gcp_region
}