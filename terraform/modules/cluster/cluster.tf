resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "boutique-cluster-aks1"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "clusteraks1"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.cluster.kube_config_raw

  sensitive = true
}