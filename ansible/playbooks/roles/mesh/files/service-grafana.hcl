# /etc/consul.d/service-grafana.hcl

service {
  name        = "grafana"
  port        = 3000
  tags        = ["monitoring", "dashboard", "frontend"]

  check {
    id       = "grafana-ready-check"
    name     = "Grafana Ready Check"
    http     = "http://localhost:3000/api/health"
    interval = "10s"
    timeout  = "2s"
  }
  connect {
    sidecar_service {
      proxy {
        upstreams = [
          {
            destination_name = "loki"
            local_bind_port  = 3100
          }
        ]
      }
    }
  }
}