resource "random_id" "random_password" {
  byte_length = 8
}

resource "azurerm_network_interface" "nic_static_ip" {
  name                 = "${format("%s-ubuntu-nic-%d", var.name, count.index)}"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  count                = "${length(var.private_ip_addresses)}"
  tags                 = "${merge(var.tags, map("Name", format("%s-ubuntu-nic-%d", var.name, count.index)))}"
  enable_ip_forwarding = "${var.enable_ip_forwarding}"

  ip_configuration {
    name                          = "${format("%s-ubuntu-nic-static-%d-ip", var.name, count.index)}"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "${var.private_ip_addresses[count.index]}"
  }
}

resource "azurerm_network_interface" "nic_dynamic_ip" {
  name                 = "${format("%s-ubuntu-nic-%d", var.name, count.index)}"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  count                = "${var.vm_count - length(var.private_ip_addresses)}"
  tags                 = "${merge(var.tags, map("Name", format("%s-ubuntu-nic-dynamic-%d", var.name, count.index)))}"
  enable_ip_forwarding = "${var.enable_ip_forwarding}"

  ip_configuration {
    name                          = "${format("%s-ubuntu-nic-%d-ip", var.name, count.index)}"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_virtual_machine" "private_ubuntu_vm" {
  name                  = "${format("%s-ubuntu-vm-%d", var.name, count.index)}"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group_name}"
  count                 = "${var.vm_count}"
  network_interface_ids = ["${element(concat(azurerm_network_interface.nic_static_ip.*.id, azurerm_network_interface.nic_dynamic_ip.*.id), count.index)}"]
  vm_size               = "${var.vm_size}"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "${var.ubuntu_sku}"
    version   = "latest"
  }

  storage_os_disk {
    name          = "${format("%s-ubuntu-vm-os-disk-%d", var.name, count.index)}"
    vhd_uri       = "${format("%s%s-ubuntu-vm-os-disk-%d.vhd", var.vhd_uri_base, var.name, count.index)}"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "${format("%s-ubuntu-vm-%d", var.name, count.index)}"
    admin_username = "ubuntu"
    admin_password = "${format("Pwd1234%s!", random_id.random_password.b64)}"
    custom_data    = "${base64encode(file(var.user_data_file))}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/ubuntu/.ssh/authorized_keys"
      key_data = "${file(var.ssh_public_keyfile)}"
    }
  }

  tags = "${merge(var.tags, map("Name", format("%s-ubuntu-vm-%d", var.name, count.index)))}"
}
