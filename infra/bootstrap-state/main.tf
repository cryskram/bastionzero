terraform {
  required_version = ">= 1.7.1, < 2.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 8.11.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "us-central1"
}

variable "project_id" {
  type        = string
  description = "google cloud project id"
}

variable "state_bucket_name" {
  type        = string
  description = "bucket name"
}

resource "google_storage_bucket" "terraform_state" {
  name                        = var.state_bucket_name
  location                    = "us-central1"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
  force_destroy               = false

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  labels = {
    purpose = "terraform-state"
    project = "bastionzero"
  }
}

output "state_bucket" {
  value = google_storage_bucket.terraform_state.name
}
