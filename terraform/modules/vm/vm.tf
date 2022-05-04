# Azure Generic VM Module
resource "azurerm_network_interface" "interface" {
  name                = "nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.interface.id
  network_security_group_id = var.security_group_id
}

data "azurerm_image" "vault-image" {
  name = "VAULT-ubuntu"
  resource_group_name = var.resource_group_name
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                  = "Standard_Ds1_v2" #3.5GiB #Standard_D2s_v3 - 8GiB
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.interface.id]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # source_image_reference {
  #   publisher = "Canonical"
  #   offer     = "UbuntuServer"
  #   sku       = "18.04-LTS"
  #   version   = "latest"
  # }

  source_image_id = data.azurerm_image.vault-image.id
}
