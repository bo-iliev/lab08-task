variable "public_subnet_ids" {
  description = "The list of IDs of the public subnets where the ELB will be placed"
  type        = list(string)
}


variable "elb_security_group_id" {
  description = "The ID of the security group for the ELB"
  type        = string
}
