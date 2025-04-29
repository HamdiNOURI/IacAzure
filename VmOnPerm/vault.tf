data "vault_kv_secret_v2" "esxi" {
  mount = "secret"
  name  = "esxi/admin"
}
