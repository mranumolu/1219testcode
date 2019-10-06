#
# Virtual Network
#
terraform {
  required_version = "0.12.9"
}

provider "random" {
  version = "2.2.0"
}
provider "azurerm" {
  version = "1.34.0"
    subscription_id = var.subscription_id
    client_id       = var.client_id
    client_secret   = var.client_secret
    tenant_id       = var.tenant_id
}

locals {
  name  = "${var.prefix}-rg"
}

resource "azurerm_resource_group" "resource-group" {
  name     = local.name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  location            = var.location
  address_space       = var.address_space
  resource_group_name = var.resource_group_name
  dns_servers         = var.dns_servers
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_names[count.index]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group_name
  address_prefix       = var.subnet_prefixes[count.index]
  count                = length(var.subnet_names)
  service_endpoints    = var.subnet_service_endpoints[count.index]
  
}
