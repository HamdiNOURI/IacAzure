terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2.0"
    }
  }
}
provider "vault" {
  address = "http://192.168.1.199:32001/" # adapte l'adresse si besoin
  token   = "root"                        # ou utilise VAULT_TOKEN dans ton shell
}

provider "vsphere" {
  user                 = data.vault_kv_secret_v2.esxi.data["user"]
  password             = data.vault_kv_secret_v2.esxi.data["password"]
  vsphere_server       = "myvcenter.kmea.local"
  allow_unverified_ssl = true
}

