variable "resource_group_name" {
    description =  "Azure resource group ka naam"
    type = string
}

variable "location" {
    description =  "Azure region"
    type = string
}

variable "vm_size" {
    description =  "Virtual machine ka size"
    type = string
}

variable "admin_username" {
    description =  "Virtual machine ke admin username"
    type = string
}

variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
}