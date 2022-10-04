terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.22.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "0.4.0"
    }
  }

  # Only needed for local execution. Set automatically in ADO pipeline
  backend "azurerm" {
    storage_account_name       = ""
    container_name             = ""
    key                        = ""
    access_key                 = ""
  }
}

provider "azurerm" {
  features{}
  skip_provider_registration = true
}

provider "azapi" {
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags

  lifecycle {
    ignore_changes = [
        tags
    ]
  }
}

module "log_analytics_workspace" {
  source                           = "./modules/log_analytics"
  name                             = var.log_analytics_workspace_name
  location                         = var.location
  resource_group_name              = azurerm_resource_group.rg.name
  tags                             = var.tags
  depends_on = [
    azurerm_resource_group.rg,
  ]
}

module "application_insights" {
  source                           = "./modules/application_insights"
  name                             = var.application_insights_name
  location                         = var.location
  resource_group_name              = azurerm_resource_group.rg.name
  tags                             = var.tags
  application_type                 = var.application_insights_application_type
  workspace_id                     = module.log_analytics_workspace.id
  depends_on = [
    azurerm_resource_group.rg,
    module.log_analytics_workspace
  ]
}

module "storage_account" {
  source                           = "./modules/storage_account"
  name                             = var.storage_account_name
  location                         = var.location
  resource_group_name              = azurerm_resource_group.rg.name
  tags                             = var.tags
  account_kind                     = var.storage_account_kind
  account_tier                     = var.storage_account_tier
  replication_type                 = var.storage_account_replication_type
  depends_on = [
    azurerm_resource_group.rg,
  ]
}

module "postgresql_server" {
  source                  = "./modules/postgresql_server"
  delegated_subnet_id     = var.postgresql_server_delegated_subnet_id
  private_dns_zone_id     = var.postgresql_server_private_dns_zone_id
  location                = var.location
  name                    = var.postgresql_server_name
  resource_group_name     = azurerm_resource_group.rg.name
  zone                    = var.postgresql_server_zone
  administrator_login     = var.postgresql_server_administrator_login
  administrator_password  = var.postgresql_server_administrator_password
  sku                     = var.postgresql_server_sku
  server_version          = var.postgresql_server_version
  server_storage          = var.postgresql_server_storage
  tags                    = var.tags
  depends_on = [
    azurerm_resource_group.rg,
  ]
}

module "container_registry" {
  source              = "./modules/container_registry"
  admin_enabled       = var.container_registry_admin_enabled
  location            = var.location
  name                = var.container_registry_name
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.container_registry_sku
  tags                = var.tags
  depends_on = [
    azurerm_resource_group.rg,
  ]
}

module "container_env" {
  source                           = "./modules/container_env"
  managed_environment_name         = var.managed_environment_name
  location                         = var.location
  resource_group_id                = azurerm_resource_group.rg.id
  tags                             = var.tags
  instrumentation_key              = module.application_insights.instrumentation_key
  workspace_id                     = module.log_analytics_workspace.workspace_id
  primary_shared_key               = module.log_analytics_workspace.primary_shared_key
  subnet_id                        = var.managed_environment_subnet_id
   
  depends_on = [
    azurerm_resource_group.rg,
    module.application_insights
  ]
}