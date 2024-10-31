# Proxmox services

# bypass ssh fingerprint

```
❯ cat ~/.ansible.cfg
[defaults]
host_key_checking = False
```

Terraform/Ansible scripts to setup self-hosted services on Proxmox

```bash
./terraform/

terraform init

terraform apply

terraform destroy -target=proxmox_lxc.unifi
```

```bash
./ansible/

ansible-playbook ./playbooks/jellyfin.yml
```

```bash
ssh-keygen -R "traefik.test"; ssh-keygen -R "192.168.1.4"
```
