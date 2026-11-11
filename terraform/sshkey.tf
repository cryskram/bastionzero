resource "krutrim_sshkey" "admin" {
  key_name   = "bastionzero-admin"
  public_key = trimspace(file(pathexpand(var.ssh_public_key_path)))
  region     = var.region
}
