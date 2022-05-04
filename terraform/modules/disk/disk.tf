# Managed disk source for VM
resource "azurerm_managed_disk" "disk" {
  name                 = "acctestmd1"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"

  tags = {
    environment = "staging"
  }
}