# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Create postgresql server

# You need to use a GP size or better to support the virtual
# Network rules. Basic version of Azure Postgres doesn't support it
resource "azurerm_postgresql_flexible_server" "SOSPgsql" {
  name                = local.pg_name
  location            = var.location
  resource_group_name = azurerm_resource_group.boundary.name

  administrator_login          = var.db_username
  #administrator_login_password = var.db_password

  sku_name   = "Standard_B1ms"
  version    = "15.3"
  storage_mb = 32768

  backup_retention_days        = 14
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = false

  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_3"

}

#Lock down access to only the controller subnet
resource "azurerm_postgresql_virtual_network_rule" "vnet" {
  name                = "postgresql-vnet-rule"
  resource_group_name = azurerm_resource_group.boundary.name
  server_name         = azurerm_postgresql_flexible_server.SOSPgsql.name
  subnet_id           = module.vnet.vnet_subnets[0]

  # Setting this to true for now, probably not necessary
  #ignore_missing_vnet_service_endpoint = true
}
