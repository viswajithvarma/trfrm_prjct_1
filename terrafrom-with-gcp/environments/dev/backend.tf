# Backend configuration for dev environment
terraform {
  backend "gcs" {
    bucket  = "terraform-state-tst-devops-intrvw"
    prefix  = "terraform/state/dev"
  }
}
