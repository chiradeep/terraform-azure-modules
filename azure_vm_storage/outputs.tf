output "vhd_uri_base" {
  value = "${azurerm_storage_account.mod_account.primary_blob_endpoint}${azurerm_storage_container.mod_container.name}/"
}
