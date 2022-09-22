output "vpc_id" {
  description = "VPC Id."
  value       = aws_vpc.axyya-vpc.id
}

output "subnet_ids" {
  value = aws_subnet.public_subnets.*.id
}

output "axyya_sg" {
  value = aws_security_group.axyya-security-group1.id
}

output "axyya_sg2" {
  value = aws_security_group.axyya-security-group2.id
}
