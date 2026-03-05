output "ssh_connection_string" {
  value = "ssh -i ${var.key_name}.pem ec2-user@${aws_eip.web.public_ip}"
}