# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# The reference architecture creates a new Vnet
# You might not want a new Vnet. Too bad.
variable "location" {
  type    = string
  default = "francecentral"
}

variable "address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  type = list(string)
  default = [
    "10.0.0.0/24",
    "10.0.1.0/24",
    "10.0.2.0/24",
  ]
}

variable "subnet_names" {
  type = list(string)
  default = [
    "controllers",
    "workers",
    "backend",
  ]
}

# This seems like a reasonable size, feel free to change
variable "controller_vm_size" {
  type    = string
  default = "Standard_B2als_v2"
}

variable "controller_vm_count" {
  type    = number
  default = 1
}

variable "worker_vm_size" {
  type    = string
  default = "Standard_B2als_v2"
}

variable "backend_vm_count" {
  type    = number
  default = 0
}

variable "backend_vm_size" {
  type    = string
  default = "Standard_B2als_v2"
}

variable "worker_vm_count" {
  type    = number
  default = 0
}

variable "db_username" {
  type    = string
  default = "scc-services-psql"
}

variable "db_password" {
  type    = string
  default = "B0un4aryPGAdm!n"
}

variable "cert_cn" {
  type    = string
  default = "scc-services-boundary-azure"
}

variable "boundary_version" {
  type    = string
  default = "0.13.1"
}

resource "random_id" "id" {
  byte_length = 4
}

locals {
  resource_group_name = "rg-bastion"

  controller_net_nsg = "bastion-controller-net"
  worker_net_nsg     = "bastion-worker-net"
  backend_net_nsg    = "bastion-backend-net"

  controller_nic_nsg = "bastion-controller-nic"
  worker_nic_nsg     = "bastion-worker-nic"
  backend_nic_nsg    = "bastion-backend-nic"

  controller_asg = "bastion-controller-asg"
  worker_asg     = "bastion-worker-asg"
  backend_asg    = "bastion-backend-asg"

  controller_vm = "bastion-controller"
  worker_vm     = "bastion-worker"
  backend_vm    = "bastion-backend"

  controller_user_id = "controller-userid"
  worker_user_id     = "worker-userid"

  pip_name = "bastion-public_ip"
  lb_name  = "bastion-load_balancer"

  vault_name = "bastion-keyvault"

  pg_name = "sos-pgsql"

  sp_name = "SOS-Boundary-Recovery SP"

  cert_san = ["boundary-${random_id.id.hex}.${var.location}.cloudapp.azure.com"]

}
