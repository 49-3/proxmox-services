- check la version plutot que le binaire exist pour consul et vault au moment de linstall

changer le nom de la pki tls (consul-serer)
consul-pki/issue/consul-server

ensuite rajouter le hostname dans le common name des consul template
{{- with secret "pki/issue/service-cert" "common_name=${env "HOSTNAME"}.service.consul" -}}
{{ .Data.private_key }}
{{ end }}