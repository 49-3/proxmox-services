terraform {
  backend "local" {
    path = "../../my-data/terraform/terraform.tfstate"
  }

  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}
