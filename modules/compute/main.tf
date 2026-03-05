# Generate a new SSH key
resource "tls_private_key" "main" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create the AWS Key Pair using the generated public key
resource "aws_key_pair" "main" {
  key_name   = var.key_name
  public_key = tls_private_key.main.public_key_openssh
}

# Save the private key locally for SSH access
resource "local_file" "private_key" {
  content         = tls_private_key.main.private_key_pem
  filename        = "${path.module}/${var.key_name}.pem"
  file_permission = "0400"
}

# EC2 Instance
resource "aws_instance" "web" {
  count                  = var.instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.subnet_id
  key_name               = aws_key_pair.main.key_name

  # Install nginx on startup
  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y nginx
    systemctl enable nginx
    systemctl start nginx
  EOF

  tags = {
    Name = "web-server-${count.index + 1}"
  }
}

# Elastic IP
resource "aws_eip" "web" {
  count    = var.instance_count
  instance = aws_instance.web[count.index].id
  domain   = "vpc"

  tags = {
    Name = "web-server-eip-${count.index + 1}"
  }
}