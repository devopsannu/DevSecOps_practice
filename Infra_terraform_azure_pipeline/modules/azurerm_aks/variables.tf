variable "child_aks_clusters" {
  type = map(object({
    aks_name            = string
    location            = string
    rg_name = string
    dns_prefix          = string
    node_count          = number
    vm_size             = string
    kubernetes_version  = optional(string)
    tags                = optional(map(string))
  }))
}