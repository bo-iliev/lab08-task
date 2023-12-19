## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.ec2_cpu_utilization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.elasticache_redis_cpu_utilization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.elb_unhealthy_hosts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.rds_cpu_utilization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_sns_topic.cloudwatch_alarms_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ec2_autoscaling_group_name"></a> [ec2\_autoscaling\_group\_name](#input\_ec2\_autoscaling\_group\_name) | The name of the EC2 Auto Scaling Group to monitor | `string` | n/a | yes |
| <a name="input_elasticache_cluster_id"></a> [elasticache\_cluster\_id](#input\_elasticache\_cluster\_id) | The identifier of the ElastiCache Redis cluster | `string` | n/a | yes |
| <a name="input_elb_name"></a> [elb\_name](#input\_elb\_name) | The name of the Elastic Load Balancer | `string` | n/a | yes |
| <a name="input_rds_instance_identifier"></a> [rds\_instance\_identifier](#input\_rds\_instance\_identifier) | The identifier of the RDS instance | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_cpu_alarm_arn"></a> [ec2\_cpu\_alarm\_arn](#output\_ec2\_cpu\_alarm\_arn) | The ARN of the EC2 CPU utilization alarm |
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | The ARN of the SNS topic for CloudWatch alarms |
