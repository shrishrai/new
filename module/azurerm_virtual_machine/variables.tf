variable "nic_name" {
  description = "The name of the network interface"
  type        = string
}

variable "nic_location" {
  description = "The Azure location where the NIC is created"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "virtual_machine_name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "virtual_machine_location" {
  description = "The Azure location where the virtual machine is created"
  type        = string
}

variable "admin_login" {
  description = "The admin login for the virtual machine"
  type        = string
}
variable "admin_password" {
  description = "The admin password for the virtual machine"
  type        = string
}