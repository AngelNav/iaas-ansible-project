output "public_ip_address_id" {
  value = azurerm_public_ip.public_ip.id
}

output "dns_name" {
  value = "${azurerm_public_ip.public_ip.domain_name_label}.${var.location}.cloudapp.azure.com"
}
