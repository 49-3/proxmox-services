resource "proxmox_vm_qemu" "consul1" {
    name = "consul1"
    desc = "Consul server 1"

    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = "pve"
    vmid = var.consul_1_vm
    # The destination resource pool for the new VM
    pool = "Management"

    # The template name to clone this vm from
    clone = "debian-12-cloud-init"
    onboot = "true"
    full_clone = "true"

    # Activate QEMU agent for this VM
    agent = 0

    os_type = "cloud-init"
    cores = 4
    sockets = 2
    vcpus = 0
    cpu = "x86-64-v2-AES"
    memory = 4096
    scsihw = "virtio-scsi-single"

    # Setup the disk
    disks {
        ide {
            ide3 {
                cloudinit {
                    storage = "local-lvm"
                }
            }
        }
        scsi {
            scsi0 {
                disk {
                    size            = 52
                    cache           = "none"
                    storage         = "local-lvm"
                    iothread        = true
                    discard         = false
                }
            }
        }
    }

    # Setup the network interface and assign a vlan tag: 256
    network {
        firewall  = false
        link_down = false
        model = "virtio"
        bridge = var.consul_bridge
        macaddr = var.consul_1_mac
        tag = -1
    }

    # Setup the ip address using cloud-init.
    boot = "order=scsi0;ide3"
    # Keep in mind to use the CIDR notation for the ip.
    ipconfig0 = "ip=${var.consul_1_ip},gw=${var.consul_gateway}"

    sshkeys = file(var.pub_ssh_key)
    cicustom = "./cloud-init/init.yml"
}
