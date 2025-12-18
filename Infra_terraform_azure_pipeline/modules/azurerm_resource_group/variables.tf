variable "resource_group" {
  description = "resource group for avengers project"
  type = map(object({
    rg_name     = string
    location = string

    tags = optional(map(string))
  }))

}
