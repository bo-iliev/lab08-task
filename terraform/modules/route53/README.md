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
| [aws_route53_record.elb_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_elb_dns_name"></a> [elb\_dns\_name](#input\_elb\_dns\_name) | The DNS name of the Elastic Load Balancer | `string` | n/a | yes |
| <a name="input_elb_zone_id"></a> [elb\_zone\_id](#input\_elb\_zone\_id) | The Zone ID of the Elastic Load Balancer | `string` | n/a | yes |
| <a name="input_hosted_zone_id"></a> [hosted\_zone\_id](#input\_hosted\_zone\_id) | The Route53 Hosted Zone ID | `string` | n/a | yes |
| <a name="input_record_name"></a> [record\_name](#input\_record\_name) | The DNS record name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_record_name"></a> [dns\_record\_name](#output\_dns\_record\_name) | The full DNS record name |
