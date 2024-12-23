# -----------------------------+
# agents-policy.hcl            |
# -----------------------------+

node_prefix "" {
    policy = "write"
}

service_prefix "" {
    policy = "write"
}

agent_prefix "" {
    policy = "write"
}

session_prefix "" {
    policy = "write"
}

key_prefix "" {
    policy = "write"
}

key_prefix "vault/" {
    policy = "write"
}

intentions {
  policy = "read"
}

# Permettre l'accès à Connect CA pour signer les certificats
path "connect/ca/sign" {
  policy = "write"
}

acl = "write"
mesh = "write"

# Pour les intentions, utilisez intention_prefix
intention_prefix "" {
    policy = "write"
}
