module "ubuntu_public_vms" {
  source = "../../ubuntu_public_vm"

  name                = "${var.base_name}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  vhd_uri_base   = "${module.storage.vhd_uri_base}"
  user_data_file = "userdata.sh"

  subnet_id          = "${module.vnet.public_subnet}"
  ssh_public_keyfile = "${var.ssh_public_keyfile}"

  vm_count = 1
}
