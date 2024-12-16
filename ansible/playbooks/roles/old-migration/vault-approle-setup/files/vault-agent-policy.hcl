# vault-agent-policy.hcl

path "pki*" {
  capabilities = ["read", "list"]
}

# Allow generating certificates
path "pki/issue/*" {
  capabilities = ["create", "update"]
}
