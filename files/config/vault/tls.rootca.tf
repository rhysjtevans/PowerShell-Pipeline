
// root ca is self-signed
resource "tls_private_key" "root_ca" {
  algorithm = "${var.ca_crypto_algo}"
  rsa_bits  = "${var.ca_crypto_rsabits}"
  ecdsa_curve = "${var.ca_crypto_ecdsacurve}"
}

# resource "local_file" "root_ca_key" {
#   content  = "${tls_private_key.root_ca.0.private_key_pem}"
#   filename = "../../../keys/ca-certs/root_ca.key"
# }

resource "tls_self_signed_cert" "root_ca" {
  key_algorithm   = "${tls_private_key.root_ca.algorithm}"
  private_key_pem = "${tls_private_key.root_ca.private_key_pem}"

  subject {
    common_name  = "root-ca"
    organization = "${var.ca_org_name}"
  }

  is_ca_certificate     = true
  validity_period_hours = 26280

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "cert_signing",
  ]
}

resource "local_file" "root_ca_cert" {
  content  = "${tls_self_signed_cert.root_ca.0.cert_pem}"
  filename = "../../../keys/ca-certs/root_ca.crt"
}
