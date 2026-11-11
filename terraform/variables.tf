variable "krutrim_account_id" {
  description = "account id for programmatic access"
  type = string
  default = null
  nullable = true
}

variable "krutrim_access_key" {
  description = "access key"
  type = string
  sensitive = true
  default = null
  nullable = true
}

variable "krutrim_secret_key" {
  description = "secret key"
  type = string
  sensitive = true
  default = null
  nullable = true
}

variable "krutrim_email" {
  description = "email; fallback auth"
  type = string
  default = null
  nullable = true
}

variable "krutrim_password" {
  description = "password; fallback auth"
  type = string
  sensitive = true
  default = null
  nullable = true
}

variable "krutrim_is_root_user" {
  description = "is root user; fallback auth"
  type = bool
  default = false
}

variable "region" {
    description = "region to deploy resources in"
    type = string
    default = "In-Bangalore-1"
}

variable "instance_type" {
  description = "compute flavor"
  type = string
  default = "CPU-1x-4GB"
}

variable "image_krn" {
  description = "ubuntu image krn"
  type        = string
  default = "ubuntu-24.04"
}

variable "root_volume_size" {
  description = "root volume size in GB"
  type        = number
  default     = 20
}

variable "ssh_public_key_path" {
  description = "ssh public key path to use for bastionzero instance"
  type        = string
  default     = "~/.ssh/id_rsa_bastionzero.pub"
}

variable "bootstrap_ssh_cidr" {
  description = "ip address with /32 to allow ssh access to bastionzero instance, or null to allow all"
  type        = string
  default     = null
  nullable    = true

  validation {
    condition = var.bootstrap_ssh_cidr == null ? true : (
      can(cidrhost(var.bootstrap_ssh_cidr, 0)) &&
      can(regex("/32$", var.bootstrap_ssh_cidr))
    )
    error_message = "use a valid CIDR with /32 suffix, or null to allow all"
  }
}
