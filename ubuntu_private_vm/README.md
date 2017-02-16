terraform module
===========

A terraform module to provide  Ubuntu VMs (defaults to 16.04 LTS) in an Azure Virtual Network. The VMs do not have any public ips assigned to them


Module Input Variables
----------------------

- `name` - Used to generate the VM name
- `vm_count` - the number of VMs
- `tags` - dictionary of tags that will be added to resources created by the module
- `resource_group_name` - the name of the resource group (tip: make this unique using the `random_id` module of terraform)
- `vhd_uri_base` - The account and container where the OS disk will be instantiated
- `user_data_file` - The file path on the local machine where the userdata file is
- `vm_size` - The size of the vm (default = `Standard_A0`)
- `ubuntu_sku`-  The Ubuntu SKU (default = `16.04.0-LTS`)
- `enable_ip_forwarding`- Whether this VM will be forwarding ip packets
- `subnet_id` - The subnet id where the NIC will be instantiated
- `private_ip_addresses` - List of static IP addresses, one per VM. If none are specified, dynamic addresses will be used
- `ssh_public_keyfile` - Local Location of the ssh public key that will be used to login to the VM

Usage
-----

```hcl
module "vm" {
  source = "github.com/chiradeep/terraform-azure-modules//ubuntu_private_vm"

  resource_group_name = "alpha-4ca23e"
  location            = "West US"
  name = "alpha"

  vhd_uri_base   = "https://alphastacctf62da8.blob.core.windows.net/alphacntrn22/"
  user_data_file = "userdata.sh"

  subnet_id          = "subnet-private-98a1e34"
  ssh_public_keyfile = "key.pub"

  vm_count = 2
}

```

Outputs
=======

 - `private_vm_ids` - ids of the vms
 - `private_vm_ips` -  private ips of the vms


License
=======

Apache 2 Licensed. See LICENSE for full details.
