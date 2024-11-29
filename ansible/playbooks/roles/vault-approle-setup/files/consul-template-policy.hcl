# consul-template-policy.hcl

path "pki/issue/internal-services" {
  capabilities = ["create", "update"]
}

path "pki/roles/internal-services" {
  capabilities = ["read"]
}

path "pki/cert/renew/*" {
  capabilities = ["update"]
}
