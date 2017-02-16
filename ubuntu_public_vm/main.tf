resource "random_id" "random_password" {
  byte_length = 8
}

resource "azurerm_public_ip" "public_ip" {
  name                         = "${format("%s-ubuntu-public-ip-%d", var.name, count.index)}"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group_name}"
  count                        = "${var.vm_count}"
  public_ip_address_allocation = "static"
  tags                         = "${merge(var.tags, map("Name", format("%s-ubuntu-public-ip-%d", var.name, count.index)))}"
}

resource "azurerm_network_interface" "public_nic" {
  name                 = "${format("%s-ubuntu-vm-public-nic-%d", var.name, count.index)}"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  tags                 = "${merge(var.tags, map("Name", format("%s-ubuntu-vm-public-nic-%d", var.name, count.index)))}"
  enable_ip_forwarding = "${var.enable_ip_forwarding}"

  ip_configuration {
    name                          = "${format("%s-ubuntu-nic-public-ip", var.name)}"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${element(azurerm_public_ip.public_ip.*.id, count.index)}"
  }
}

resource "azurerm_virtual_machine" "public_ubuntu_vm" {
  name                  = "${format("%s-ubuntu-vm-public-%d", var.name, count.index)}"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group_name}"
  count                 = "${var.vm_count}"
  network_interface_ids = ["${element(azurerm_network_interface.public_nic.*.id, count.index)}"]
  vm_size               = "${var.vm_size}"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "${var.ubuntu_sku}"
    version   = "latest"
  }

  storage_os_disk {
    name          = "${format("%s-ubuntu-public-vm-os-disk-%d", var.name, count.index)}"
    vhd_uri       = "${format("%s%s-ubuntu-public-vm-os-disk-%d.vhd", var.vhd_uri_base, var.name, count.index)}"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "${format("%s-ubuntu-public-vm-%d", var.name, count.index)}"
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

  tags = "${merge(var.tags, map("Name", format("%s-ubuntu-public-vm-%d", var.name, count.index)))}"
}
