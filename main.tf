#
# Virtual Network
#

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  location            = var.location
  address_space       = var.address_space
  resource_group_name = var.resource_group_name
  dns_servers         = var.dns_servers
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_names[count.index]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group_name
  address_prefix       = var.subnet_prefixes[count.index]
  count                = length(var.subnet_names)
  service_endpoints    = var.subnet_service_endpoints[count.index]
}