locals { 
    nsgrules = {
        ssh = {
            name                       = "SSH"
            priority                   = 1001
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "22"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
        }

        vault = {
            name                       = "vault"
            priority                   = 101
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "8200"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
        }
  }
}