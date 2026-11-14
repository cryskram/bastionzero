data "google_compute_image" "debian" {
  family  = "debian-13"
  project = "debian-cloud"
}

resource "google_service_account" "opsbeacon" {
  account_id   = "opsbeacon-runtime"
  display_name = "OpsBeacon VM runtime identity"
}

resource "google_compute_instance" "opsbeacon" {
  name         = "bastionzero-opsbeacon"
  zone         = var.zone
  machine_type = "e2-micro"
  tags         = ["bastionzero-vm", "bastionzero-web"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian.self_link
      size  = 10
      type  = "pd-standard"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.app.id
    access_config {}
  }

  metadata = {
    "enable-oslogin" : "TRUE"
  }

  service_account {
    email  = google_service_account.opsbeacon.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  allow_stopping_for_update = true

  depends_on = [
    google_compute_firewall.iap_ssh,
    google_project_iam_member.admin_iap_tunnel,
    google_project_iam_member.admin_os_login,
    google_service_account_iam_member.deployer_act_as
  ]
}
