provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = var.azure_resource_group_name
  location = var.azure_location

  tags = {
    environment = var.environment
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = var.azure_kubernetes_cluster_name
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = var.azure_dns_prefix
  kubernetes_version  = var.azure_kubernetes_version

  default_node_pool {
    name            = var.azure_node_pool_name
    node_count      = var.azure_node_count
    vm_size         = var.azure_vm_size
    os_disk_size_gb = var.azure_os_disk_size_gb
    vnet_subnet_id  = var.azure_vnet_subnet_id
  }

  service_principal {
    client_id     = var.azure_appId
    client_secret = var.azure_password
  }

  role_based_access_control_enabled = true

  tags = {
    environment = var.environment
  }
}


# Obtain credentials for the AKS cluster
resource "null_resource" "get_aks_credentials" {
  provisioner "local-exec" {
    command = "az aks get-credentials --resource-group ${var.azure_resource_group_name} --name ${azurerm_kubernetes_cluster.aks.name}"
  }

  depends_on = [azurerm_kubernetes_cluster.aks]
}

