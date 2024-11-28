-----BEGIN CERTIFICATE-----
{{ .Data.certificate }}
-----END CERTIFICATE-----
-----BEGIN PRIVATE KEY-----
{{ .Data.private_key }}
-----END PRIVATE KEY-----
-----BEGIN CERTIFICATE-----
{{ .Data.issuing_ca }}
-----END CERTIFICATE-----