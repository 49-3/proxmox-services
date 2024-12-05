#!/bin/bash

# Activer les options de sécurité
set -euo pipefail

# Chemins absolus vers les exécutables
CURL="/usr/bin/curl"
JQ="/usr/bin/jq"

# Chemins absolus vers les fichiers et configurations
UNSEAL_KEYS_FILE="/etc/vault.d/secrets/unseal_keys.txt"
CA_CERT="/etc/consul.d/tls/consul-agent-ca.pem"
VAULT_ADDR="https://127.0.0.1:8200"  # Modifier si l'adresse diffère
VAULT_API="${VAULT_ADDR}/v1/sys/seal-status"
UNSEAL_API="${VAULT_ADDR}/v1/sys/unseal"

# Fonction pour afficher les messages d'erreur
error_exit() {
    echo "Erreur : $1" >&2
    exit 1
}

# Vérifier que les exécutables existent et sont exécutables
[ -x "$CURL" ] || error_exit "curl n'est pas installé ou n'est pas exécutable."
[ -x "$JQ" ] || error_exit "jq n'est pas installé ou n'est pas exécutable."

# Vérifier que le certificat CA existe et est lisible
[ -r "$CA_CERT" ] || error_exit "Certificat CA introuvable ou non lisible : $CA_CERT"

# Fonction pour vérifier si Vault est scellé
is_sealed() {
    seal_status=$("$CURL" --silent --fail --cacert "$CA_CERT" "$VAULT_API" | "$JQ" -r '.sealed')
    if [ "$seal_status" == "true" ]; then
        return 0  # Scellé
    else
        return 1  # Désèlé
    fi
}

# Fonction pour désèler Vault
unseal_vault() {
    # Lire les clés de désèlage en évitant les problèmes de globbing et word splitting
    mapfile -t keys < "$UNSEAL_KEYS_FILE"

    key_count=${#keys[@]}

    if [ "$key_count" -eq 0 ]; then
        error_exit "Aucune clé de désèlage trouvée dans $UNSEAL_KEYS_FILE"
    fi

    echo "Désèlage de Vault avec les clés disponibles..."

    for key in "${keys[@]}"; do
        # Utiliser des guillemets pour éviter les injections
        response=$("$CURL" --silent --fail --request POST \
            --cacert "$CA_CERT" \
            --data "{\"key\":\"$key\"}" \
            "$UNSEAL_API")

        # Vérifier si la réponse contient des erreurs
        if echo "$response" | "$JQ" -e '.errors' > /dev/null; then
            echo "Erreur lors du désèlage avec une clé."
        else
            echo "Clé de désèlage appliquée avec succès."
        fi

        # Vérifier si Vault est désèlé après chaque clé
        if ! is_sealed; then
            echo "Vault a été désèlé avec succès."
            exit 0
        fi
    done

    if is_sealed; then
        error_exit "Échec du désèlage de Vault après avoir utilisé toutes les clés."
    fi
}

# Vérifier si le fichier des clés de désèlage existe et contient des clés
if [ -f "$UNSEAL_KEYS_FILE" ] && [ -s "$UNSEAL_KEYS_FILE" ]; then
    # Vérifier si Vault est scellé et désèler si nécessaire
    if is_sealed; then
        echo "Vault est actuellement scellé. Tentative de désèlage..."
        unseal_vault
    else
        echo "Vault est déjà désèlé. Aucune action nécessaire."
    fi
else
    echo "Fichier des clés de désèlage manquant ou vide : $UNSEAL_KEYS_FILE"
    echo "Bypass du processus de désèlage."
    exit 0
fi
