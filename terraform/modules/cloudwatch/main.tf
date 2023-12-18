resource "aws_sns_topic" "cloudwatch_alarms_topic" {
  name = "cloudwatch-alarms-topic"
}

resource "aws_cloudwatch_metric_alarm" "ec2_cpu_utilization" {
  alarm_name          = "ec2-cpu-utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "75"
  alarm_description   = "This metric monitors EC2 CPU utilization"

  dimensions = {
    AutoScalingGroupName = var.ec2_autoscaling_group_name
  }

  actions_enabled = true
  alarm_actions = [aws_sns_topic.cloudwatch_alarms_topic.arn]
}

# ELB Alarm for Unhealthy Hosts
resource "aws_cloudwatch_metric_alarm" "elb_unhealthy_hosts" {
  alarm_name          = "elb-unhealthy-hosts"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ELB"
  period              = "300"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "This metric monitors ELB unhealthy hosts"

  dimensions = {
    LoadBalancerName = var.elb_name
  }

  actions_enabled = true
  alarm_actions = [aws_sns_topic.cloudwatch_alarms_topic.arn]
}

# RDS Alarm for CPU Utilization
resource "aws_cloudwatch_metric_alarm" "rds_cpu_utilization" {
  alarm_name          = "rds-cpu-utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = "85"
  alarm_description   = "This metric monitors RDS CPU utilization"

  dimensions = {
    DBInstanceIdentifier = var.rds_instance_identifier
  }

  actions_enabled = true
  alarm_actions = [aws_sns_topic.cloudwatch_alarms_topic.arn]
}

# ElastiCache Redis Alarm for CPU Utilization
resource "aws_cloudwatch_metric_alarm" "elasticache_redis_cpu_utilization" {
  alarm_name          = "elasticache-redis-cpu-utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ElastiCache"
  period              = "60"
  statistic           = "Average"
  threshold           = "85"
  alarm_description   = "This metric monitors ElastiCache Redis CPU utilization"

  dimensions = {
    CacheClusterId = var.elasticache_cluster_id
  }

  actions_enabled = true
  alarm_actions = [aws_sns_topic.cloudwatch_alarms_topic.arn]
}
