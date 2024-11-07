$ export GOOGLE_CLOUD_PROJECT=<your_gcp_project_id>

# creation a bastion node to run playbook from
$ gcloud compute instances create bastion \
  --async \
  --zone us-central1-a \
  --boot-disk-size 50GB \
  --image-family ubuntu-2004-lts \
  --image-project ubuntu-os-cloud \
  --machine-type n1-standard-1 \
  --tags vault

# create three nodes in GCP
$ for i in 1 2 3; do
  gcloud compute instances create vault0${i} \
    --async \
    --zone us-central1-a \
    --boot-disk-size 50GB \
    --image-family ubuntu-2004-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-1 \
    --tags vault
done

# SSH to bastion node
$ gcloud compute ssh bastion --zone us-central1-a

# optional: generate SSL certificates
$ consul tls ca create
==> Saved consul-agent-ca.pem
==> Saved consul-agent-ca-key.pem

$ consul tls cert create -server \
  -additional-dnsname=vault01.c.$GOOGLE_CLOUD_PROJECT.internal \
  -additional-dnsname=vault02.c.$GOOGLE_CLOUD_PROJECT.internal \
  -additional-dnsname=vault03.c.$GOOGLE_CLOUD_PROJECT.internal
...
==> Using consul-agent-ca.pem and consul-agent-ca-key.pem
==> Saved dc1-server-consul-0.pem
==> Saved dc1-server-consul-0-key.pem

# create the inventory file
$ cat <<EOF > inventory
[vault_primary]
vault01.c.$GOOGLE_CLOUD_PROJECT.internal
vault02.c.$GOOGLE_CLOUD_PROJECT.internal
vault03.c.$GOOGLE_CLOUD_PROJECT.internal
EOF

# create the playbook
$ cat <<EOF > site.yml
---
- hosts: vault_primary
  become: yes
  roles:
    - role: ansible-role-vault
EOF

# optional: create group_vars directory and file
$ mkdir group_vars

$ cat <<EOF > vault_primary.yml
---
vault_storage_backend: 'integrated'
vault_version: '1.11.3+ent'

vault_tls_ca_cert_file: 'tls/consul-agent-ca.pem'
vault_tls_cert_file: 'tls/dc1-server-consul-0.pem'
vault_tls_key_file: 'tls/dc1-server-consul-0-key.pem'
vault_tls_disable_client_certs: false

vault_ansible_group: vault_primary

vault_seal:
  type: gcpkms
  project: $GOOGLE_CLOUD_PROJECT
  region: us-central1
  key_ring: vault_key_ring
  crypto_key: vault_crypto_key
EOF

# run ansible playbook
$ ansible-playbook -i inventory site.yaml

# export address for binary
$ export VAULT_ADDR=https://vault01.c.[PROJECT_ID].internal:8200

# optional: disable SSL verification
$ export VAULT_SKIP_VERIFY=true

# initalize the Vault cluster (if using Shamir)
$ vault operator init -key-shares=1 -key-threshold=1
Unseal Key 1: tMoFtiYOuBlf6757jjOl4lCvN1v4NneZhzQqwe3pzxA=

Initial Root Token: s.8OZR9fj3g3mJoxDKlUaE48Yx

Success! Vault is initialized
...

# initalize the Vault cluster (if using Autounseal)
$ vault operator init -recovery-shares=1 -recovery-threshold=1
Recovery Key 1: tMoFtiYOuBlf6757jjOl4lCvN1v4NneZhzQqwe3pzxA=

Initial Root Token: s.8OZR9fj3g3mJoxDKlUaE48Yx

Success! Vault is initialized
...

# unseal each Vault node if using Shamir
$ vault operator unseal tMoFtiYOuBlf6757jjOl4lCvN1v4NneZhzQqwe3pzxA

# authenticate to Vault with the root token
$ vault login s.8OZR9fj3g3mJoxDKlUaE48Yx
Success! You are now authenticated. The token information displayed below
is already stored in the token helper. You do NOT need to run "vault login"
again. Future Vault requests will automatically use this token.
...

# verify raft peer list
$ vault operator raft list-peers
Node                               Address                                 State       Voter
----                               -------                                 -----       -----
vault01.c.[PROJECT_ID].internal    vault01.c.[PROJECT_ID].internal:8201    leader      true
vault02.c.[PROJECT_ID].internal    vault02.c.[PROJECT_ID].internal:8201    follower    true
vault03.c.[PROJECT_ID].internal    vault03.c.[PROJECT_ID].internal:8201    follower    true