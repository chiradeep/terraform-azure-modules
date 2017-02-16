output "public_vm_ids" {
  value = ["${azurerm_virtual_machine.public_ubuntu_vm.*.id}"]
}

output "public_vm_ips" {
  value = ["${azurerm_public_ip.public_ip.*.ip_address}"]
}

output "public_vm_fqdns" {
  value = ["${azurerm_public_ip.public_ip.*.fqdn}"]
}
