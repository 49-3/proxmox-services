# -----------------------------+
# agents-policy.hcl            |
# -----------------------------+

node_prefix "" {
     policy = "write"
}
service_prefix "" {
    policy = "read"
}
agent_prefix "" {
    policy = "read"
}

key_prefix "vault/" {
    policy = "write"
}

key_prefix "splitfire/" {
    policy = "read"
}

service "vault" {
    policy = "write"
}

service "consul" {
    policy = "write"
}

agent_prefix "consul-" {
    policy = "write"
}

session_prefix "" {
    policy = "write"
}
mesh = "write"
acl  = "write"