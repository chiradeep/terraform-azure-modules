module "ubuntu_private_vms" {
  source = "../../ubuntu_private_vm"

  name                = "${var.base_name}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  vhd_uri_base   = "${module.storage.vhd_uri_base}"
  user_data_file = "userdata.sh"

  subnet_id          = "${module.vnet.private_subnet}"
  ssh_public_keyfile = "${var.ssh_public_keyfile}"

  vm_count = 2

  private_ip_addresses = ["10.120.10.51"]
}
