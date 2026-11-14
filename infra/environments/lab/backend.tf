terraform {
  backend "gcs" {
    bucket = "bastionzero-lab-151387483139-tfstate-1794682789"
    prefix = "terraform/lab"
  }
}
