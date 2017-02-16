terraform module
===========

A terraform module to configure a storage account and container for VM storage in Azure



Module Input Variables
----------------------

- `name` - Used as a part of the storage account name. The account name itself uses a random generator to make this globally unique (across all Azure accounts!)
- `resource_group_name` - the name of the resource group (tip: make this unique using the `random_id` module of terraform)
- `storage_account_type` - the type of the of storage account to be created, e.g., `Standard_LRS, Standard_ZRS, Standard_GRS`
- `container_access_type` - Can be either blob, container or private. Tip: Leave at default = private
- `tags` - dictionary of tags that will be added to resources created by the module

Usage
-----

```hcl
module "storage" {
  source = "github.com/chiradeep/terraform-azure-modules//azure_vm_storage"

  name                = "alpha1"
  location            = "West US"
  resource_group_name = "alpha-1e3d2a"
  tags {
    "Terraform" = "true"
    "Environment" = "${var.environment}"
  }
}
```

Outputs
=======

 - `vhd_uri_base`:  A base for the disk URI to be specified during VM creation. E.g., `https://alphastacctf62da8.blob.core.windows.net/alphacntrn22/`. Append a disk name (`osdisk1.vhd`) to generate the disk name for the VM


License
=======

Apache 2 Licensed. See LICENSE for full details.
