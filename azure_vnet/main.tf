resource "azurerm_virtual_network" "mod" {
  name                = "${format("%s-vnet", var.name)}"
  address_space       = ["${var.cidr}"]
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  tags                = "${merge(var.tags, map("Name", format("%s", var.name)))}"
}

resource "azurerm_route_table" "public" {
  name                = "${format("%s-rt-public", var.name)}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  route {
    name           = "route_local"
    address_prefix = "${var.cidr}"
    next_hop_type  = "vnetlocal"
  }

  route {
    name           = "route_default"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }

  tags = "${merge(var.tags, map("Name", format("%s-rt-public", var.name)))}"
}

resource "azurerm_subnet" "public" {
  name                 = "${format("%s-subnet-public", var.name)}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.mod.name}"
  address_prefix       = "${var.public_subnet}"
  route_table_id       = "${azurerm_route_table.public.id}"
}

resource "azurerm_route_table" "private" {
  count               = "${var.private_subnet == "" ? 0: 1}"
  name                = "${format("%s-rt-private", var.name)}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  route {
    name           = "route_local"
    address_prefix = "${var.cidr}"
    next_hop_type  = "vnetlocal"
  }

  tags = "${merge(var.tags, map("Name", format("%s-rt-private", var.name)))}"
}

resource "azurerm_subnet" "private" {
  count                = "${var.private_subnet == "" ? 0: 1}"
  name                 = "${format("%s-subnet-private", var.name)}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.mod.name}"
  address_prefix       = "${var.private_subnet}"
  route_table_id       = "${azurerm_route_table.private.id}"
}
