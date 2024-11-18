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
key_prefix "" {
    policy = "write"
}
key_prefix "vault/" {
    policy = "write"
}
service "" {
  policy = "write"
}
session_prefix "" {
    policy = "write"
}
node "" {
    policy = "write"
}

mesh = "write"
acl  = "write"
