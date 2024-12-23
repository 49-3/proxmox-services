.PHONY: help
help: ## List all makefile targets with their descriptions
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: traefik
traefik: ## Run the Traefik playbook
	bash -c "time ansible-playbook playbooks/traefik.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: consul_bootstrap
consul_bootstrap: ## Run the Consul bootstrap playbook
	bash -c "time ansible-playbook playbooks/consul-bootstrap.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: consul_template
consul_template: ## Run the Consul Template setup playbook
	bash -c "time ansible-playbook playbooks/consul-template.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: vault_bootstrap
vault_bootstrap: ## Run the Vault bootstrap playbook
	bash -c "time ansible-playbook playbooks/vault-bootstrap.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: vault_restart_unsealed
vault_restart_unsealed: ## Restart Vault in unsealed mode
	bash -c "time ansible-playbook playbooks/vault-restart-unsealed.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: vault_key_value
vault_key_value: ## Set up key-value secrets in Vault
	bash -c "time ansible-playbook playbooks/vault-key-value.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: vault_agent_autauth
vault_agent_autauth: ## Configure Vault Agent with auto-authentication
	bash -c "time ansible-playbook playbooks/vault-agent-autauth.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: vault_consul_migration
vault_consul_migration: ## Migrate Consul certificates and CA to Vault
	bash -c "time ansible-playbook playbooks/vault-consul-migration.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: consul_renew_certs
consul_renew_certs: ## Renew Consul certificates using Vault
	bash -c "time ansible-playbook playbooks/consul-restart-renew-certs.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: vault_approle_setup
vault_approle_setup: ## Configure Vault AppRole authentication
	bash -c "time ansible-playbook playbooks/vault-approle-setup.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: vault_pki_setup
vault_pki_setup: ## Set up PKI (Public Key Infrastructure) in Vault
	bash -c "time ansible-playbook playbooks/vault-pki-setup.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: vault_agent_setup
vault_agent_setup: ## Deploy and configure Vault Agent
	bash -c "time ansible-playbook playbooks/vault-agent-setup.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: acl-vault-consul
acl-vault-consul: ## Restore ACLs for Consul and Vault data directories
	bash -c "time ansible-playbook playbooks/acl-vault-consul.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: display-secrets
display-secrets: ## Display the secrets stored in the secrets directory
	bash -c "time ansible-playbook playbooks/display-secrets.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: vault-mtls
vault-mtls: ##Run the vault-mtls playbook (site.yml)
	bash -c "time ansible-playbook vault-mtls.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: monitoring
monitoring: ## Run the monitoring playbook (site.yml)
	bash -c "time ansible-playbook monitoring.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: promtail
promtail: ## Run the promtail playbook (site.yml)
	bash -c "time ansible-playbook playbooks/promtail.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: kubes
kubes: ## Run the kubes playbook (site.yml)
	bash -c "time ansible-playbook kubes.yml --ssh-common-args='-o StrictHostKeyChecking=no'"


.PHONY: re
re: ## Clear secrets and run the alls playbooks (site.yml)
	rm -rf ~/secret/* ; \
	bash -c "time ansible-playbook consul-vault.yml --ssh-common-args='-o StrictHostKeyChecking=no'" && \
	bash -c "time ansible-playbook monitoring.yml --ssh-common-args='-o StrictHostKeyChecking=no'"
# bash -c "time ansible-playbook vault-mtls.yml --ssh-common-args='-o StrictHostKeyChecking=no'"
# bash -c "time ansible-playbook kubes.ynl --ssh-common-args='-o StrictHostKeyChecking=no'"

# Default target
.DEFAULT_GOAL := re_no_rm