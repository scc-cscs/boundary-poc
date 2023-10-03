# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "boundary_auth_method_password" "password" {
  name        = "Login_password"
  description = "Connexion par Login / mot de passe"
  scope_id    = boundary_scope.org.id
}

output "auth_method_id" {
  value = boundary_auth_method_password.password.id
}