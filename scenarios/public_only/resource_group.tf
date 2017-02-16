resource "random_id" "random_suffix" {
  byte_length = 3
}

resource "azurerm_resource_group" "resource_group" {
  name     = "${format("rg-%s-%s", var.base_name, random_id.random_suffix.hex)}"
  location = "${var.location}"
}
