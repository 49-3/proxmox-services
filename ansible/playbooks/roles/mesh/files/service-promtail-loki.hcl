# /etc/consul.d/service-promtail.hcl

service {
  name        = "promtail-loki"
  port        = 9080
  tags        = ["logging", "agent", "promtail"]

  check {
    id       = "promtail-{{ inventory_hostname }}-ready-check"
    name     = "Promtail {{ inventory_hostname }} Ready Check"
    http     = "http://localhost:9080/ready"
    interval = "10s"
    timeout  = "2s"
  }
}