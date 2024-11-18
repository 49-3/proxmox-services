default: help

.PHONY: help
help: ## list makefile targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: consul_bootstrap
consul_bootstrap: ## Launch consul-bootstrap playbook
	bash -c "time ansible-playbook playbooks/consul-bootstrap.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: consul_template
consul_template: ## Launch consul-template playbook
	bash -c "time ansible-playbook playbooks/consul-template.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: vault_bootstrap
vault_bootstrap: ## Launch vault-bootstrap playbook
	bash -c "time ansible-playbook playbooks/vault-bootstrap.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: vault_restart_unsealed
vault_restart_unsealed: ## Launch vault-bootstrap playbook
	bash -c "time ansible-playbook playbooks/vault-restart-unsealed.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: vault_key_value
vault_key_value: ## Launch vault-key-value playbook
	bash -c "time ansible-playbook playbooks/vault-key-value.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: vault_agent_autauth
vault_agent_autauth: ## Launch vault-key-value playbook
	bash -c "time ansible-playbook playbooks/vault-agent-autauth.yml --ssh-common-args='-o StrictHostKeyChecking=no'"

.PHONY: vault_consul_migration
vault_consul_migration: ## Launch vault-key-value playbook
	bash -c "time ansible-playbook playbooks/vault-consul-migration.yml --ssh-common-args='-o StrictHostKeyChecking=no'"


.PHONY: re
re: ## clear secret and run ansible on site.yml
	rm -rf ~/secret/* ; bash -c "time ansible-playbook site.yml --ssh-common-args='-o StrictHostKeyChecking=no'"
