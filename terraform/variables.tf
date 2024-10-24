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

variable "traefik_bridge" {
  type    = string
  default = "vGate"
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

// Runners

variable "runners_vm" {
  type    = number
  default = 2006
}

variable "runners_mac" {
  type    = string
  default = "B8:1A:E4:C6:88:03"
}

variable "runners_bridge" {
  type    = string
  default = "vMgt"
}

variable "runners_ip" {
  type    = string
  default = "10.0.20.26/24"
}

variable "runners_gateway" {
  description = "runners gateway IP"
  type        = string
  default     = "10.0.20.254"
}

// Staging

variable "staging_vm" {
  type    = number
  default = 5001
}

variable "staging_mac" {
  type    = string
  default = "BC:24:11:A6:0A:4F"
}

variable "staging_bridge" {
  type    = string
  default = "vStaging"
}

variable "staging_ip" {
  type    = string
  default = "10.0.50.21/24"
}

variable "staging_gateway" {
  description = "staging gateway IP"
  type        = string
  default     = "10.0.50.254"
}