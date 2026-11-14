output "instance_name" {
  value = google_compute_instance.opsbeacon.name
}

output "instance_zone" {
  value = google_compute_instance.opsbeacon.zone
}

output "instance_internal_ip" {
  value = google_compute_instance.opsbeacon.network_interface[0].network_ip
}

output "instance_external_ip" {
  value = try(google_compute_instance.opsbeacon.network_interface[0].access_config[0].nat_ip, null)
}
