variable "base_name" {}

variable "location" {
  description = "The name of the Azure region (e.g., West US)"
  default     = "West US"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "ssh_public_keyfile" {
  description = "The file location (local) of the ssh rsa public key that is used to login to the vm"
}
