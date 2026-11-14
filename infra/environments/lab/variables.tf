variable "project_id" {
  type        = string
  description = "Google Cloud project ID"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "enable_public_web" {
  type        = bool
  description = "Open 80/443 only after the app and reverse proxy are ready"
  default     = false
}

variable "admin_email" {
  type        = string
  description = "Google identity email used for IAP and OS Login administration"
}
