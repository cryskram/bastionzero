resource "google_compute_network" "main" {
  name                    = "bastionzero-vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "app" {
  name                     = "bastionzero-subnet"
  region                   = var.region
  network                  = google_compute_network.main.id
  ip_cidr_range            = "10.20.0.0/24"
  private_ip_google_access = true
}

resource "google_compute_firewall" "iap_ssh" {
  name      = "bastionzero-allow-iap-ssh"
  network   = google_compute_network.main.name
  direction = "INGRESS"
  priority  = 1000

  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["bastionzero-vm"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "public_web" {
  count     = var.enable_public_web ? 1 : 0
  name      = "bastionzero-allow-public-web"
  network   = google_compute_network.main.name
  direction = "INGRESS"
  priority  = 1000

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["bastionzero-web"]

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
}
