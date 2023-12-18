output "ec2_cpu_alarm_arn" {
  description = "The ARN of the EC2 CPU utilization alarm"
  value       = aws_cloudwatch_metric_alarm.ec2_cpu_utilization.arn
}

output "sns_topic_arn" {
  description = "The ARN of the SNS topic for CloudWatch alarms"
  value       = aws_sns_topic.cloudwatch_alarms_topic.arn
}