variable "resource_group_name" {
  description = "The name of the resource group under which the resources will be created"
}

variable "name" {}

variable "location" {
  description = "The name of the Azure region (e.g., West US)"
}

variable "cidr" {
  description = "CIDR for the virtual network, e.g., 10.100.0.0/16"
}

variable "public_subnet" {
  description = "CIDR for the public subnet, e.g., 10.100.101.0/24"
}

variable "private_subnet" {
  description = "CIDR for the private subnet, e.g., 10.100.91.0/24. If left empty, no private subnet will be created"
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}
