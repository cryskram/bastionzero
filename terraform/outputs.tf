output "instance_krn" {
  description = "krutrim resource identifier for the vm"
  value = krutrim_instance.bastion.id
}

output "instance_status" {
  description = "vm status"
  value = krutrim_instance.bastion.status
}

output "public_ip" {
  description = "floating ip"
  value = krutrim_instance.bastion.floating_ip
}

output "private_id" {
  description = "private id"
  value = krutrim_instance.bastion.private_ip_address
}

output "ssh_key_name" {
  description = "registered krutrim ssh key name"
  value = krutrim_sshkey.admin.key_name
}
