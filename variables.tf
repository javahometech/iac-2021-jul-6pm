variable "vpc_cidr" {
  default     = "100.10.0.0/16"
  type        = string
  description = "Provide CIDR for vpc"
}
variable "tenancy" {
  default = "default"
}

variable "vpc_tags" {
  type = map(string)
  default = {
    Location   = "Banglore"
    Department = "HR"
    CostCenter = "BLR11HBY345"
  }
}