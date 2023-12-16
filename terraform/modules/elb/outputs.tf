output "elb_dns_name" {
  description = "The DNS name of the ELB"
  value       = aws_elb.web_elb.dns_name
}

output "elb_name" {
  description = "The name of the ELB"
  value       = aws_elb.web_elb.name
}