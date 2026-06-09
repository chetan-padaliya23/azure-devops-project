output "resource_group_name" {
  description = "Azure resource group ka naam"
  value = var.resource_group_name
}

output "location" {
  description = "Azure region"
  value = var.location
}

output "vm_public_ip" {
  description = "VM ka public IP address"
  value = azurerm_public_ip.public_ip.ip_address
}