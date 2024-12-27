# /etc/consul.d/service-alertmanager.hcl

service {
  name = "alertmanager"
  id   = "alertmanager" # Un identifiant unique pour le service
  port = 9093

  # Tags facultatifs pour catégoriser le service
  tags = [
    "monitoring",
    "alertmnanager",
    "prometheus"
  ]

  # Définition des connecteurs si vous utilisez Consul Connect
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
      }
    }
  }

  # Définition des vérifications de santé
  check {
    name     = "vérification de l'état de Alertmanager"
    interval = "120s"
    timeout  = "20s"
    deregister_critical_service_after = "5m"

    # URL de la vérification de santé (readiness ou liveness)
    http = "http://localhost:9093/-/ready"

    # Optionnel : définir les en-têtes HTTP si nécessaire
    # headers = {
    #   "Authorization" = "Bearer <token>"
    # }
  }
}