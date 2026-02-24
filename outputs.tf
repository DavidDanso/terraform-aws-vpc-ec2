output "vpc_id" {
  description = ""
  value       = aws_vpc.main.id
}

output "public_ip" {
  value = aws_eip.web.public_ip
}

output "public_dns" {
  value = aws_eip.web.public_dns
}

output "ssh_connection_string" {
  value = "ssh -i ${var.key_name}.pem ec2-user@${aws_eip.web.public_ip}"
}