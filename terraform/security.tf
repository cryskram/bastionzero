resource "krutrim_security_group" "bastion" {
  name = "bastionzero-sg"
  description = "bastionzero vm ingress egress policy"
  vpc_id = krutrim_vpc.main.id
  region = var.region
}

resource "krutrim_security_group_rule" "ssh_bootstrap" {
  count = var.bootstrap_ssh_cidr == null ? 0 : 1
  security_group_id = krutrim_security_group.bastion.id
  vpc_id = krutrim_vpc.main.id
  description = "temporary ssh from host ip"
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_min_range = 22
  port_max_range = 22
  remote_ip_prefix = var.bootstrap_ssh_cidr
  region = var.region
}

resource "krutrim_security_group_rule" "egress_tcp" {
  security_group_id = krutrim_security_group.bastion.id
  vpc_id = krutrim_vpc.main.id
  description = "outbound tcp for dns and etc"
  direction = "egress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_max_range = 65535
  port_min_range = 1
  remote_ip_prefix = "0.0.0.0/0"
  region = var.region
}

resource "krutrim_security_group_rule" "egress_udp" {
  security_group_id = krutrim_security_group.bastion.id
  vpc_id            = krutrim_vpc.main.id
  description       = "outbound udp for tailscale and wireguard"
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_min_range    = 1
  port_max_range    = 65535
  remote_ip_prefix  = "0.0.0.0/0"
  region            = var.region
}
