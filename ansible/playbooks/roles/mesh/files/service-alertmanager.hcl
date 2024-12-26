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
    sidecar_service {}
  }

  # Définition des vérifications de santé
  check {
    name     = "vérification de l'état de Alertmanager"
    interval = "30s"
    timeout  = "5s"

    # URL de la vérification de santé (readiness ou liveness)
    http = "http://localhost:9093/-/ready"

    # Optionnel : définir les en-têtes HTTP si nécessaire
    # headers = {
    #   "Authorization" = "Bearer <token>"
    # }
  }
}