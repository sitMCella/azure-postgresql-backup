locals {
  tags = {
    environment = var.environment
  }
}

resource "azurerm_resource_group" "resource_group" {
  name     = "rg-${var.workload_name}-${var.environment}-${var.location_abbreviation}-001"
  location = var.location
}

module "virtual_network" {
  source = "./modules/network"

  resource_group_name   = azurerm_resource_group.resource_group.name
  location              = var.location
  location_abbreviation = var.location_abbreviation
  environment           = var.environment
  tags                  = local.tags
}

module "storage_account" {
  source = "./modules/storage_account"

  resource_group_name                = azurerm_resource_group.resource_group.name
  location                           = var.location
  location_abbreviation              = var.location_abbreviation
  environment                        = var.environment
  allowed_public_ip_addresses        = var.allowed_public_ip_addresses
  allowed_virtual_network_subnet_ids = [module.virtual_network.subnet_aks_id]
  tags                               = local.tags
}

module "kubernetes_cluster" {
  source = "./modules/kubernetes_cluster"

  resource_group_name   = azurerm_resource_group.resource_group.name
  location              = var.location
  location_abbreviation = var.location_abbreviation
  environment           = var.environment
  dns_prefix            = "${var.workload_name}${var.environment}${var.location_abbreviation}"
  vnet_subnet_id        = module.virtual_network.subnet_aks_id
  authorized_ip_ranges  = var.allowed_public_ip_address_ranges
  storage_account_id    = module.storage_account.storage_account_id
  subscription_id       = var.subscription_id
  tags                  = local.tags
}

module "postgresql_database" {
  source = "./modules/postgresql"

  resource_group_name    = azurerm_resource_group.resource_group.name
  location               = var.location
  location_abbreviation  = var.location_abbreviation
  environment            = var.environment
  administrator_login    = var.postgresql_administrator_login
  administrator_password = var.postgresql_administrator_password
  tags                   = local.tags
}

module "application" {
  source = "./modules/application"

  container_registry_name         = module.kubernetes_cluster.container_registry_name
  container_registry_login_server = module.kubernetes_cluster.container_registry_login_server
  subscription_id                 = var.subscription_id
}
