Sample Scenario
===========

Sample terraform config that uses the modular Terraform Azure configs. A virtual network with a public  subnet (and associated route table) is created. One Ubuntu 16 VM is created in the public subnet


Input Variables
----------------------

- `base_name` - Used to generate names for all the resources created. Keep it short and DNS compliant
- `tags` - dictionary of tags that will be added to resources created by the module
- `location` - Azure location (e.g., West US')
- `ssh_public_keyfile` - the filename of the public rsa key used to ssh into the Ubuntu VM


Usage
-----

```
terraform apply -var 'base_name=alpha' -var 'location="West US"' -var 'ssh_public_keyfile=my_key.pub'
```

Outputs
=======

```
terraform output -module <module name>
```

License
=======

Apache 2 Licensed. See LICENSE for full details.
