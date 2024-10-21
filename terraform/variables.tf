variable "proxmox_api_url" {
  description = "The Proxmox API URL"
  type        = string
  default     = "https://192.168.1.180:8006/api2/json"
}

variable "proxmox_user" {
  description = "The Proxmox user"
  type        = string
  default     = "terraform-prov@pve"
}

variable "proxmox_password" {
  description = "The Proxmox user password"
  type        = string
}

variable "pub_ssh_key" {
  description = "Public SSH key for passwordless login/Ansible admining"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "gateway_ip" {
  description = "LXC gateway IP"
  type        = string
  default     = "192.168.1.1"
}

//
// Services variables
//


// Traefic

variable "traefik_lxcid" {
  type    = number
  default = 1002
}

variable "traefik_mac" {
  type    = string
  default = "B6:1A:E1:C6:86:03"
}

variable "traefik_ip" {
  type    = string
  default = "10.0.10.12/24"
}

variable "traefik_gateway" {
  description = "traefic gateway IP"
  type        = string
  default     = "10.0.10.254"
}
