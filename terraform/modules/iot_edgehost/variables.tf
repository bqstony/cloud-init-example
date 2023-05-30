####################
# MODULE VARIABLES #
####################

variable "input_resourcegroup_name" {
  description = "The name of the ressource group to deploy in"
  type        = string
}

variable "input_ressource_prefix" {
  description = "The prefix of the created ressource name"
  type        = string
}

variable "input_ressource_middlename" {
  description = "The middlename of the created ressource name"
  type        = string
}

variable "input_ressource_location" {
  description = "The Resource Location as long name used in Azure like: Switzerland North"
  type        = string
  default     = "Switzerland North"
  validation {
    condition     = contains(["Switzerland North", "westeurope"], var.input_ressource_location)
    error_message = "The location has to be Switzerland North or westeurope"
  }
}

variable "input_environment" {
  description = "The environment stage name like dev, test, prod. Max 4 chars."
  type        = string
  validation {
    condition     = length(var.input_environment) <= 4
    error_message = "The environment name has to be prod, test or dev"
  }
}

variable "input_tags" {
  description = "A List of key=value Tag that allways have to be set"
  type        = map(string)
}

variable "input_vm_nic_subnet_id" {
  description = "The subnet id of a vnet to connect to. It must already exist! The ip adress of the interface is assigned by DHCP"
  type        = string
}

variable "input_vm_admin_username" {
  description = "The admin username of the Linux Virtual maschine"
  type        = string
}

variable "input_vm_admin_password" {
  description = "The admin password of the Linux Virtual maschine"
  type        = string
  sensitive   = true
}

variable "input_vm_cloudinit_path" {
  description = "The relative file path to the cloud-init yaml file."
  type        = string
}

variable "input_edge_connectionstring" {
  description = "The azure IOT HUB Device connectionstring."
  type        = string
  sensitive   = true
}

variable "input_edge_cert_filenmae" {
  description = "The filename of the edge certificate that are bound to the service container."
  type        = string
}
