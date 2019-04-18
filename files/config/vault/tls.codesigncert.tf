resource "tls_private_key" "codesign_key" {
  algorithm = "${var.ca_crypto_algo}"
  rsa_bits  = "${var.ca_crypto_rsabits}"
  ecdsa_curve = "${var.ca_crypto_ecdsacurve}"
}

resource "local_file" "codesign_key" {
  content  = "${tls_private_key.codesign_key.private_key_pem}"
  filename = "../../../keys/certs/codesign.key"
}




resource "tls_cert_request" "codesign" {
  key_algorithm   = "${var.ca_crypto_algo}"
  private_key_pem = "${tls_private_key.codesign_key.private_key_pem}"

  subject {
    common_name = "${local.codesign_cn}"
    organization = "${var.ca_org_name}"
  }
}
resource "vault_pki_secret_backend_sign" "codesign" {
  common_name = "${local.codesign_cn}"
  backend = "${vault_pki_secret_backend.pki.path}"
  csr = "${tls_cert_request.codesign.cert_request_pem}"
  name = "${vault_pki_secret_backend_role.codesign.name}"
}


resource "local_file" "codesign_cert" {
  content  = "${vault_pki_secret_backend_sign.codesign.certificate}\n${vault_pki_secret_backend_sign.codesign.issuing_ca}"
  filename = "../../../keys/certs/codesign.crt"
}
