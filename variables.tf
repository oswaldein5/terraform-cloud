#* Define vars
variable "virgina_cidr" {
  description = "CIDR Virginia"
  type        = string
}

# variable "public_subnet" {
#   description = "CIDR public subnet"
#   type = string
# }

# variable "private_subnet" {
#   description = "CIDR private subnet"
#   type = string
# }

variable "subnets" {
  description = "Subnet list"
  type        = list(string)
}

variable "tags" {
  description = "Project Tags"
  type        = map(string)
}

variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

variable "ec2_specs" {
  description = "EC2 Specs"
  type        = map(string)
}

variable "enable_monitoring" {
  description = "Enable deploy monitoring server"
  type        = number
}

variable "ingress_ports_list" {
  description = "Ingress Ports"
  type        = list(number)
}

variable "access_key" {

}

variable "secret_key" {

}
