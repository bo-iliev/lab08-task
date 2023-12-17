variable "ssh_public_key" {
  type        = string
  description = "Provide your public key to allow SSH access to the instance (e.g. cat ~/.ssh/id_rsa.pub)"
}

variable "db_username" {
  type        = string
  description = "Provide a username for the database"
}

variable "db_password" {
  type = string
  description = "Provide a password for the database"
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}