output "public_ips" {
  description = "The public IPs of the EC2 instances"
  value       = module.compute.public_ips
}

output "public_dns" {
  description = "The public DNS names of the EC2 instances"
  value       = module.compute.public_dns
}

output "ssh_connection_strings" {
  description = "SSH commands to connect to the EC2 instances"
  value       = module.compute.ssh_connection_strings
}
