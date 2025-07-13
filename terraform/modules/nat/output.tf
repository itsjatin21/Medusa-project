output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.main.id
}

output "nat_eip" {
  description = "Elastic IP attached to NAT Gateway"
  value       = aws_eip.nat.public_ip
}
