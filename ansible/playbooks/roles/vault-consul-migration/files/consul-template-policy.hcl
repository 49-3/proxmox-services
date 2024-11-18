path "consul-pki/issue/consul-servers" {
  capabilities = ["create", "read", "update", "list"]
}

path "auth/token/renew-self" {
  capabilities = ["update"]
}
