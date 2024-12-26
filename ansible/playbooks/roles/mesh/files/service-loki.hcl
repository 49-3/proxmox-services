# /etc/consul.d/service-loki.hcl

service {
  name        = "loki"
  port        = 3100
  tags        = ["logging", "storage", "backend"]

  check {
    id       = "loki-ready-check"
    name     = "Loki Ready Check"
    http     = "http://localhost:3100/ready"
    interval = "10s"
    timeout  = "2s"
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