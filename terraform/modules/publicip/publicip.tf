resource "azurerm_public_ip" "public_ip" {
  name                = "${var.resource_type}-pubip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  domain_name_label = "vm-boutique"
}
