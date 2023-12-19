variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type."
  type        = string
  default     = "t2.micro"
}

variable "public_subnet_id" {
  description = "The ID of the public subnet for the bastion host"
  type        = string
}

variable "bastion_sg_id" {
  description = "The ID of the bastion host security group"
  type        = string
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

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_user" {
  description = "The username for the database"
  type        = string
}

variable "db_password" {
  description = "The password for the database"
  type        = string
}

variable "db_host" {
  description = "The database host endpoint"
  type        = string
}

variable "redis_host" {
  description = "The Redis host endpoint"
  type        = string
}