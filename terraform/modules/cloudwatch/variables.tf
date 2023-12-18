variable "ec2_autoscaling_group_name" {
  description = "The name of the EC2 Auto Scaling Group to monitor"
  type        = string
}

variable "elb_name" {
  description = "The name of the Elastic Load Balancer"
  type        = string
}

variable "rds_instance_identifier" {
  description = "The identifier of the RDS instance"
  type        = string
}

variable "elasticache_cluster_id" {
  description = "The identifier of the ElastiCache Redis cluster"
  type        = string
}