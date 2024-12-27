# /etc/consul.d/service-loki.hcl

service {
  name        = "loki"
  port        = 3100
  tags        = ["logging", "storage", "backend"]

  check {
    id       = "loki-ready-check"
    name     = "Loki Ready Check"
    http     = "http://localhost:3100/ready"
    interval = "120s"
    timeout  = "20s"
    deregister_critical_service_after = "5m"
  }

  connect {
    sidecar_service {
      proxy {
        upstreams = [
          {
            destination_name = "alertmanager"
            local_bind_port  = 9093
          }
        ]
      }
    }
  }
}