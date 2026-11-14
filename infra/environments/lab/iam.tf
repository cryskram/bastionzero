resource "google_project_iam_member" "admin_iap_tunnel" {
  project = var.project_id
  role    = "roles/iap.tunnelResourceAccessor"
  member  = "user:${var.admin_email}"
}

resource "google_project_iam_member" "admin_os_login" {
  project = var.project_id
  role    = "roles/compute.osAdminLogin"
  member  = "user:${var.admin_email}"
}

resource "google_service_account_iam_member" "deployer_act_as" {
  service_account_id = google_service_account.opsbeacon.name
  role               = "roles/iam.serviceAccountUser"
  member             = "user:${var.admin_email}"
}
