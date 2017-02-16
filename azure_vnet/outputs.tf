output "private_subnet" {
  value = "${azurerm_subnet.private.id}"
}

output "public_subnet" {
  value = "${azurerm_subnet.public.id}"
}

output "vnet_id" {
  value = "${azurerm_virtual_network.mod.id}"
}

output "public_route_table_id" {
  value = "${azurerm_route_table.public.id}"
}

output "private_route_table_id" {
  value = "${azurerm_route_table.private.id}"
}
