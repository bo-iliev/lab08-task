output "dns_record_name" {
  description = "The full DNS record name"
  value       = "${aws_route53_record.elb_record.name}.${aws_route53_record.elb_record.zone_id}"
}
