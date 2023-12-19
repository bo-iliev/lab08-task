variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}


variable "public_subnets" {
  description = "A map of public subnets"
  type = map(object({
    cidr_block = string
    az         = string
  }))
}

variable "private_subnets" {
  description = "A map of private subnets with their CIDR blocks and AZs"
  type = map(object({
    cidr_block = string
    az         = string
  }))
}
