resource "proxmox_lxc" "traefik" {
  target_node     = "pve"
  hostname        = "traefik"
  ostemplate      = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  password        = "evilP4ssw0rd"
  unprivileged    = true
  ostype          = "debian"
  nameserver      = "10.0.10.254"
  ssh_public_keys = file(var.pub_ssh_key)
  start           = true
  onboot          = true
  vmid            = var.traefik_lxcid

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "25G"
  }

  network {
    name   = "eth0"
    bridge = "vGate"
    gw     = var.traefik_gateway
    ip     = var.traefik_ip
    ip6    = "auto"
    hwaddr = var.traefik_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage
    ]
  }
}
