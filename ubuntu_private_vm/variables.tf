variable "resource_group_name" {
  description = "The name of the resource group under which the resources will be created"
}

variable "name" {}

variable "location" {
  description = "The name of the Azure region (e.g., West US)"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "vm_count" {
  description = "The number of vms to instantiate"
  default     = 1
}

variable "vhd_uri_base" {
  description = "The account and container where the OS disk will be instantiated"
}

variable "user_data_file" {
  description = "The file path on the local machine where the userdata file is"
}

variable "vm_size" {
  description = "The size of the vm"
  default     = "Standard_A0"
}

variable "ubuntu_sku" {
  description = "The Ubuntu SKU"
  default     = "16.04.0-LTS"
}

variable "enable_ip_forwarding" {
  description = "Whether this VM will be forwarding ip packets"
  default     = false
}

variable "subnet_id" {
  description = "The subnet id where the NIC will be instantiated"
}

variable "private_ip_addresses" {
  description = "List of static RFC1918 addresses, one per VM. Ensure that at least vm_count are specified, or none"
  default     = []
}

variable "ssh_public_keyfile" {
  description = "Local Location of the ssh public key that will be used to login to the VM"
}
