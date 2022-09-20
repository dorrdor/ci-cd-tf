variable "RG" {
  type        = string
  default     = "vmssrg"
  description = "bonus resource group"
}

variable "loc" {
  type        = string
  default     = "West Europe"
  description = "resorce location"
}

variable "VN" {
  type        = string
  default     = "VN"
  description = "bonus vitual natworkn"
}

variable "vmssrg" {
}

variable "VN_ID" {
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




