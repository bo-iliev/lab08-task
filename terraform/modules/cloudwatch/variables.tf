variable "cloudwatch_sns_topic_arn" {
  description = "The ARN of the SNS topic for CloudWatch alarms."
  type        = string
  default     = "arn:aws:sns:eu-central-1:123456789012:my-sns-topic" # Replace with your SNS topic ARN
}

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