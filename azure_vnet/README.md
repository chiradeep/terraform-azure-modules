terraform module
===========

A terraform module to provide a Virtual Network in Azure. Two subnets - 1 public and 1 private (optional) along with route tables are created


Module Input Variables
----------------------

- `name` - vnet name
- `cidr` - vnet cidr
- `public_subnet` - public subnet cidr
- `private_subnet` - private subnet cidr. If this is left to default (`""`), then no private subnet is created
- `tags` - dictionary of tags that will be added to resources created by the module
- `resource_group_name` - the name of the resource group (tip: make this unique using the `random_id` module of terraform)


Usage
-----

```hcl
module "vnet" {
  source = "github.com/chiradeep/terraform-azure-modules//azure_vnet"

  resource_group_name = "alpha-4ca23e"
  location            = "West US"
  name = "alpha"

  cidr           = "10.120.0.0/16"
  private_subnet = "10.120.10.0/24"
  public_subnet  = "10.120.20.0/24"


  cidr = "10.0.0.0/16"

  tags {
    "Terraform" = "true"
    "Environment" = "${var.environment}"
  }
}
```

Outputs
=======

 - `vnet_id` - id of the virtual network
 - `private_subnet` -  private subnet id
 - `public_subnet` -  public subnet id
 - `public_route_table_id` - public route table id
 - `private_route_table_id` - private route table id


License
=======

Apache 2 Licensed. See LICENSE for full details.
