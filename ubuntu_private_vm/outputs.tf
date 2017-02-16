output "private_vm_ids" {
  value = ["${azurerm_virtual_machine.private_ubuntu_vm.*.id}"]
}

output "private_vm_ips" {
  value = ["${concat(azurerm_network_interface.nic_static_ip.*.private_ip_address, azurerm_network_interface.nic_dynamic_ip.*.private_ip_address)}"]
}
