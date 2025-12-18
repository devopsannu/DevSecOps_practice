variable "secrets" {

  type = map(object({
    key_name            = string
    rg_name             = string
    secret_name         = string
    secret_value        = string
  }))
}
