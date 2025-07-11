output "nat_public_ip_address" {
  value = azurerm_public_ip.this.ip_address
}

output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}

output "vnet_id" {
  value = azurerm_virtual_network.main.id
}
