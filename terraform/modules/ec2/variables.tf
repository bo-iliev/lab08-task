variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
  default     = "ami-06dd92ecc74fdfb36" # Replace with your desired AMI
}

variable "instance_type" {
  description = "The EC2 instance type."
  type        = string
  default     = "t2.micro"
}

variable "subnet_ids" {
  description = "The IDs of the subnets in which to launch the instances"
  type        = list(string)
}


variable "security_group_id" {
  description = "The ID of the security group to associate with the EC2 instance"
  type        = string
}

variable "instance_name" {
  description = "The name tag for the EC2 instance"
  default     = "WordPressInstance"
}

variable "ssh_public_key" {
  type        = string
  description = "Provide your public key to allow SSH access to the instance (e.g. cat ~/.ssh/id_rsa.pub)"
}

variable "asg_max_size" {
  description = "The maximum size of the auto scaling group"
  type        = number
}

variable "asg_min_size" {
  description = "The minimum size of the auto scaling group"
  type        = number
}

variable "asg_desired_capacity" {
  description = "The desired number of instances in the auto scaling group"
  type        = number
}

variable "elb_name" {
  description = "The name of the ELB"
  type        = string
}