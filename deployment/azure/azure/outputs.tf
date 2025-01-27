# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# These outputs are used by the Boundary terraform config as inputs
# to perform the initial configuration of Boundary

output "vault_name" {
  value = local.vault_name
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "url" {
  value = "https://${azurerm_public_ip.boundary.fqdn}:9200"
}

output "client_id" {
  value = azuread_service_principal.SOS-Boundary-Recovery_SP.application_id
}

output "client_secret" {
  value = azuread_service_principal_password.SOS-Boundary-Recovery_SP.value
}

output "target_ips" {
  value = azurerm_network_interface.backend[*].private_ip_address
}

output "public_dns_name" {
  value = azurerm_public_ip.boundary.fqdn
}