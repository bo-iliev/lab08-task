variable "public_subnet_id" {
  description = "The ID of the public subnet where the ELB will be placed"
  type        = string
}

variable "elb_security_group_id" {
  description = "The ID of the security group for the ELB"
  type        = string
}
