# /etc/consul.d/service-grafana.hcl

service {
  name        = "grafana"
  port        = 3000
  tags        = ["monitoring", "dashboard", "frontend"]

  check {
    id       = "grafana-ready-check"
    name     = "Grafana Ready Check"
    http     = "http://localhost:3000/api/health"
    interval = "120s"
    timeout  = "20s"
    deregister_critical_service_after = "5m"
  }
  connect {
    sidecar_service {
      proxy {
        config {
          # Port 'applicatif' du sidecar
          listener = [
            {
              port = 19001
            }
          ]
          # Port admin Envoy (indispensable pour éviter 19000)
          admin_bind_address = "127.0.0.1:19010"
        }
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