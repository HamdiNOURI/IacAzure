data "vault_kv_secret_v2" "admin_creds" {
  mount = "secret"
  name  = "AzureWin/admin"
} 
data "vault_kv_secret_v2" "azure" {
  mount = "secret"
  name  = "azure/creds"
}