# terraform {
#     backend "azurerm" {
#         resource_group_name = "angel-hernandez-tm"
#         storage_account_name = "value"
#         container_name = "tf-state"
#         key = "terraform.tfstate"
#     }
# }

data "azurerm_resource_group" "rg" {
  name = "angel-herandez-tm"
}

# Cluster Kubernetes
module "cluster" {
  source              = "./modules/cluster"
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Create virtual network
module "vpc" {
  source              = "./modules/vpc"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}

module "publicip" {
  source              = "./modules/publicip"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  resource_type       = "publicip"
}

# Create virtual machine
module "vm" {
  source               = "./modules/vm"
  resource_group_name  = data.azurerm_resource_group.rg.name
  location             = data.azurerm_resource_group.rg.location
  public_ip_address_id = module.publicip.public_ip_address_id
  subnet_id            = module.vpc.subnet_id
  security_group_id    = module.vpc.security_group_id
}

output "vpc_module_outputs" {
  value = module.vpc
}
output "publicip_module_outputs" {
  value = module.publicip
}
