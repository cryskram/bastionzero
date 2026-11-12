resource "krutrim_vpc" "main" {
  description = "vpc setup for krutrim"
  region = var.region
  name = "bastionzero-vpc"
  network_name = "bastionzero-network"
  subnet_name = "bastionzero-subnet"
  cidr = "10.42.0.0/24"
  gateway_ip = "10.42.0.1"

  ip_version = "4"
  ingress = true
  egress = true
}
