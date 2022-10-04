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
}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.tags, local.module_tag)
}

resource "azurerm_postgresql_flexible_server" "resource" {
  delegated_subnet_id     = var.delegated_subnet_id
  private_dns_zone_id     = var.private_dns_zone_id
  location                = var.location
  name                    = var.name
  resource_group_name     = var.resource_group_name
  zone                    = var.zone
  administrator_login     = var.administrator_login
  administrator_password  = var.administrator_password
  sku_name                = var.sku
  version                 = var.server_version
  storage_mb              = var.server_storage
  tags                    = var.tags

  lifecycle {
    ignore_changes = [
        tags
    ]
  }
}