default: help

.PHONY: help
help: ## list makefile targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: vault_init
vault_init: ## clear secret and run ansible  on site.yml
	bash -c "time ansible-playbook playbooks/vault.yml --ssh-common-args='-o StrictHostKeyChecking=no'"


.PHONY: re
re: ## clear secret and run ansible  on site.yml
	rm -rf ~/secret/* ; bash -c "time ansible-playbook site.yml --ssh-common-args='-o StrictHostKeyChecking=no'"
