path "sys/mounts/pki" {
  capabilities = [ "read" ]
}

path "sys/mounts/pki_int" {
  capabilities = [ "read" ]
}

path "sys/mounts/pki_int/tune" {
  capabilities = [ "update" ]
}

path "pki/ca" {
  capabilities = ["read"]
}

path "pki/root/sign-intermediate" {
  capabilities = ["update"]
}

path "pki_int/ca" {
  capabilities = ["read"]
}

path "pki_int/issue/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "auth/token/renew-self" {
  capabilities = [ "update" ]
}

path "auth/token/lookup-self" {
  capabilities = [ "read" ]
}

path "pki_int/roles/*" {
  capabilities = ["create","update","read","delete","list"]
}
