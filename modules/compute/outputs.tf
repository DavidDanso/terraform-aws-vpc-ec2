output "public_ips" {
  description = "The public IP addresses of the instances"
  value       = aws_eip.web[*].public_ip
}

output "public_dns" {
  description = "The public DNS names of the instances"
  value       = aws_eip.web[*].public_dns
}

output "ssh_connection_strings" {
  description = "SSH connection strings to access the instance"
  value       = [for ip in aws_eip.web[*].public_ip : "ssh -i ${var.key_name}.pem ec2-user@${ip}"]
}
