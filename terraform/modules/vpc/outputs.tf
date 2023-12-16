output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = [for subnet in aws_subnet.private : subnet.id]
}


output "ec2_security_group_id" {
  description = "The ID of the security group for EC2 instances"
  value       = aws_security_group.ec2_sg.id
}

output "elb_security_group_id" {
  description = "The ID of the security group for the ELB"
  value       = aws_security_group.elb_sg.id
}

output "rds_security_group_id" {
  description = "The ID of the security group for RDS instances"
  value       = aws_security_group.rds_sg.id
}

output "elasticache_security_group_id" {
  description = "The ID of the security group for Elasticache"
  value       = aws_security_group.elasticache_sg.id
}
