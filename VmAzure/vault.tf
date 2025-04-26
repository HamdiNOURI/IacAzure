data "vault_kv_secret_v2" "admin_creds" {
  mount = "secret"
  name  = "AzureWin/admin"
}