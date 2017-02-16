module "vnet" {
  source = "../../azure_vnet"

  name                = "${var.base_name}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  cidr          = "10.120.0.0/16"
  public_subnet = "10.120.20.0/24"
}
