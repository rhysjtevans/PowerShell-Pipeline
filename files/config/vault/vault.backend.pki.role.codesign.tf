resource "vault_pki_secret_backend_role" "codesign" {
  backend = "${vault_pki_secret_backend.pki.path}"
  name    = "codesign"
  use_csr_common_name = true
  use_csr_sans = true
  allow_any_name = true
  ttl = 600
  max_ttl = 9000
  code_signing_flag = true
  key_usage = [
    "DigitalSignature",
    "KeyAgreement",
    "KeyEncipherment"
    ]
}
