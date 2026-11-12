resource "krutrim_instance" "bastion" {
  region        = var.region
  name          = "bastionzero"
  instance_type = var.instance_type

  vpc_id     = krutrim_vpc.main.id
  subnet_id  = krutrim_vpc.main.subnet_id
  network_id = krutrim_vpc.main.network_id

  volume_type = "ssd"
  volume_name = "bastionzero-root"
  volume_size = var.root_volume_size

  image_krn   = var.image_krn
  sshkey_name = krutrim_sshkey.admin.key_name

  is_gpu                = false
  floating_ip           = true
  delete_on_termination = true

  security_groups = [
    krutrim_security_group.bastion.id
  ]
}
