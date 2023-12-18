variable "hosted_zone_id" {
  description = "The Route53 Hosted Zone ID"
  type        = string
}

variable "record_name" {
  description = "The DNS record name"
  type        = string
}

variable "elb_dns_name" {
  description = "The DNS name of the Elastic Load Balancer"
  type        = string
}

variable "elb_zone_id" {
  description = "The Zone ID of the Elastic Load Balancer"
  type        = string
}
