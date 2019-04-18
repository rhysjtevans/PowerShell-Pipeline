
// intermediate cert is signed by root ca
resource "tls_private_key" "intermediate_ca" {
  algorithm = "${var.ca_crypto_algo}"
  rsa_bits  = "${var.ca_crypto_rsabits}"
  ecdsa_curve = "${var.ca_crypto_ecdsacurve}"
}

# resource "local_file" "intermediate_ca_key" {
#   content  = "${tls_private_key.intermediate_ca.0.private_key_pem}"
#   filename = "../../../keys/ca-certs/intermediate_ca.key"
# }

# resource "tls_cert_request" "intermediate_ca" {
#   key_algorithm   = "${tls_private_key.intermediate_ca.algorithm}"
#   private_key_pem = "${tls_private_key.intermediate_ca.private_key_pem}"

#   subject {
#     common_name  = "intermediate-ca"
#     organization = "${local.organization}"
#   }
# }
resource "vault_pki_secret_backend_intermediate_cert_request" "subca_csr" {
  depends_on = [ "vault_pki_secret_backend.pki" ]

  backend = "${vault_pki_secret_backend.pki.path}"

  type = "internal"
  common_name = "subca.internal.io"
}

resource "tls_locally_signed_cert" "intermediate_ca" {
#   cert_request_pem = "${tls_cert_request.intermediate_ca.0.cert_request_pem}"
  cert_request_pem = "${vault_pki_secret_backend_intermediate_cert_request.subca_csr.csr}"

  ca_key_algorithm   = "${tls_private_key.root_ca.algorithm}"
  ca_private_key_pem = "${tls_private_key.root_ca.private_key_pem}"
  ca_cert_pem        = "${tls_self_signed_cert.root_ca.cert_pem}"

  is_ca_certificate     = true
  validity_period_hours = 26280

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "cert_signing",
  ]
}

resource "local_file" "intermediate_ca_cert" {
  content  = "${tls_locally_signed_cert.intermediate_ca.0.cert_pem}"
  filename = "../../../keys/ca-certs/intermediate_ca.crt"
}
