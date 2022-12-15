variable resource_group_name {
  type        = string
  description = "The name of the Resource Group to access the resources"
}

variable "location" {
    type  = string
    description ="location where resource group must be placed"
  default = "East US"
}
variable resource_name {
  type        = string
  description = "Resource name to be added as prefix to the name of the services"
}
variable address_space {
  type        = string
  description = "Virtual Network Address Space"
}
variable address_prefix {
  type        = string
  description = "Address prefix for the subnet"
}

variable vm_size {
  type    = string
  default = "Standard_DS1_v2"
}
variable image_publisher {
  type        = string
  description = "name of the Image publisher"
}
variable image_offer {
  type        = string
  description = "name of the Image offer"
}
variable sku {
  type        = string
  description = "sku for the vm"
}

variable image_version {
  type    = string
  default = "latest"
}
variable caching {
  type    = string
  default = "ReadWrite"
}
variable create_option {
  type    = string
  default = "FromImage"
}
variable storage_account_type {
  type    = string
  default = "Standard_LRS"
}
variable pass {
  type  = string
  description = "Password"
}

