resource "vault_pki_secret_backend" "pki" {
  path = "pki"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds = 86400
}



resource "vault_pki_secret_backend_intermediate_set_signed" "intermediate" { 
  backend = "${vault_pki_secret_backend.pki.path}"

  certificate = "${tls_locally_signed_cert.intermediate_ca.cert_pem}"
}
