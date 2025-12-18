variable "child_nic_nsg_association" {
  description = "A map of NIC to NSG associations"
  type = map(object({
    nic_name = string
    nsg_name = string
    rg_name  = string
  }))
  
}