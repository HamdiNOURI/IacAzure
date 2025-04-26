provider "vault" {
  address = "http://192.168.1.199:32001/" # adapte l'adresse si besoin
  token   = "root"                        # ou utilise VAULT_TOKEN dans ton shell
}

provider "azurerm" {
  features {}

  subscription_id = data.vault_kv_secret_v2.azure.data["subscription_id"]
  tenant_id       = data.vault_kv_secret_v2.azure.data["tenant_id"]
  client_id       = data.vault_kv_secret_v2.azure.data["client_id"]
  #client_secret   = data.vault_kv_secret_v2.azure.data["client_secret"]
}
