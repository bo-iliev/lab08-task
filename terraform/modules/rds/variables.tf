variable "db_allocated_storage" {
  description = "The allocated storage size for the RDS instance"
  type        = number
}

variable "db_storage_type" {
  description = "The storage type of the RDS instance"
  type        = string
  default     = "gp2"
}

variable "db_engine" {
  description = "The database engine to use"
  type        = string
}

variable "db_engine_version" {
  description = "The engine version to use"
  type        = string
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created"
  type        = string
}

variable "db_username" {
  description = "Username for the database"
  type        = string
}

variable "db_password" {
  description = "Password for the database"
  type        = string
}

variable "db_parameter_group_name" {
  description = "The name of the DB parameter group to associate with this DB instance"
  type        = string
}

variable "db_subnet_ids" {
  description = "The subnets associated with the DB instance"
  type        = list(string)
}

variable "rds_security_group_id" {
  description = "The security group ID for the RDS instance"
  type        = string
}

variable "db_backup_retention_period" {
  description = "The backup retention period in days"
  type        = number
  default     = 7
}

variable "db_backup_window" {
  description = "The daily time range during which automated backups are created"
  type        = string
}

variable "db_maintenance_window" {
  description = "The weekly time range during which system maintenance can occur"
  type        = string
}
