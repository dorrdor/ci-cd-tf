variable "RG" {
  # type        = string
  # default     = "ss"
  # description = "bonus resource group"
}

# variable "ss" {
# }

variable "loc" {
  type        = string
  default     = "West Europe"
  description = "resorce location"
}

variable "VN" {
}


variable "SUB" {
  type        = string
  default     = "SUB"
  description = "ssvm-subnet"
}

variable "VMSS" {
  type        = string
  default     = "VMSS"
  description = "vmss scaleset"
}

variable "LB" {
  type        = string
  default     = "LB"
  description = "azurerm lb"
}

variable "username" {
  type        = string
  default     = "adminuser"
  description = "description"
}




