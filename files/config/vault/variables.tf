variable "vault_token" {
  default = "s.AYhaYV5bf4PjNPmfzK4ptNvW"
}

variable "fqdn" {
  description = "Used to generated the certificate authority fqdn."
  default = "internal.io"
}
variable "ca_org_name" {
  default = "My Org"
}

variable "ca_crypto_algo" {
  default = "RSA"
}
variable "ca_crypto_rsabits" {
  default = "4096"
}
variable "ca_crypto_ecdsacurve" {
    default = "P521"
}


locals {
  codesign_cn = "codesigner.${var.fqdn}"
}
