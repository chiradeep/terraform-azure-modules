resource "random_id" "random_suffix" {
  byte_length = 3
}

resource "azurerm_storage_account" "mod_account" {
  name                = "${format("%sstacct%s", var.name, random_id.random_suffix.hex)}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  account_type        = "${var.storage_account_type}"

  tags = "${merge(var.tags, map("Name", format("%s-storage-account", var.name)))}"
}

resource "azurerm_storage_container" "mod_container" {
  name                  = "${format("%s-stge-cntnr", var.name)}"
  resource_group_name   = "${var.resource_group_name}"
  storage_account_name  = "${azurerm_storage_account.mod_account.name}"
  container_access_type = "${var.container_access_type}"
}
