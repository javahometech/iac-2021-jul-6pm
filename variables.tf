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

variable "ingress" {
  type = map(object({
    port = number
    protocol = string
    cidrs = list(string)
  }))
  default = {
    "80" = {
      cidrs = [ "0.0.0.0/0" ]
      port = 80
      protocol = "tcp"
    }
    "443" = {
      cidrs = [ "0.0.0.0/0" ]
      port = 443
      protocol = "tcp"
    }
    "22" = {
      cidrs = [ "172.16.0.0/20", "172.21.0.0/20" ]
      port = 22
      protocol = "tcp"
    }
  }
}