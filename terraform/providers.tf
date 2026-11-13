terraform {
  required_version = ">= 1.17.2, < 2.0.0"
  required_providers {
    google = {
      source  = "hasicorp/google"
      version = "~> 8.11.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
