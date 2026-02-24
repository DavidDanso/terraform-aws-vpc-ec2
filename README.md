<div align="center">
  <h1>🚀 AWS VPC & EC2 Web Server Foundation</h1>
  <p><i>Infrastructure-as-Code fundamentals demonstrating Terraform and AWS networking expertise.</i></p>

  <!-- Badges -->
  <img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform" />
  <img src="https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white" alt="AWS" />
  <img src="https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white" alt="Nginx" />
</div>

<br />

## 📋 Overview

This project provisions a secure, custom AWS Virtual Private Cloud (VPC) from scratch using **HashiCorp Terraform**. It dynamically deploys public and private subnets across multiple Availability Zones, sets up routing and internet access, and provisions an EC2 instance running an Nginx web server. 

### Why This Project Matters
This repository serves as a foundational demonstration of **Infrastructure-as-Code (IaC)** principles. It proves a practical understanding of:
- **Terraform Workflows:** State management, variables, outputs, and the `init`/`plan`/`apply`/`destroy` lifecycle.
- **AWS Networking:** VPCs, CIDR block division, Internet Gateways, Route Tables, and Security Groups.
- **Compute Provisioning:** Automating EC2 deployments with bootstrap scripts (User Data) and dynamically generated SSH keys.

---

## 🏗️ Architecture

The infrastructure is designed with security and high availability in mind, featuring:

- **Custom VPC** with a configurable CIDR block.
- **4 Subnets** across 2 Availability Zones (2 Public, 2 Private) for high availability.
- **Internet Gateway & Route Tables** bridging the public subnets to the internet.
- **Security Groups** restricting ingress strictly to HTTP/HTTPS (`80`, `443`) and SSH (`22`).
- **EC2 Web Server** running Amazon Linux 2023, automatically bootstrapped with Nginx.
- **Elastic IP (EIP)** for static public access.
- **Dynamic TLS Key Generation** for secure, automated SSH access without hardcoded keys.

---

## 🚀 Quick Start Guide

### Prerequisites

* [Terraform](https://developer.hashicorp.com/terraform/downloads) CLI (`~> 6.0`)
* AWS CLI installed and configured (`aws configure`) with valid credentials.

### 1. Clone & Configure

```bash
git clone https://github.com/yourusername/vpc-ec2-web-server.git
cd vpc-ec2-web-server
```

Open `terraform.tfvars` to customize your variables. Update `ami_id` to a valid Amazon Linux AMI in your chosen `aws_region`:

```hcl
aws_region           = "us-east-1"
instance_type        = "t2.micro"
ami_id               = "ami-0f3caa1cf4417e51b" # Ensure this matches your region!
key_name             = "vpc-ec2-web-server-keyPair"
```

### 2. Initialize Terraform
Downloads the required AWS, TLS, and Local providers.
```bash
terraform init
```

### 3. Plan the Deployment
Validates the configuration and previews the resources Terraform will create.
```bash
terraform validate
terraform plan
```

### 4. Apply the Infrastructure
Provisions the resources in your AWS account. Type `yes` when prompted.
```bash
terraform apply
```

---

## 🧪 Verification & Testing

Once `terraform apply` completes successfully, Terraform will output your `public_dns`, `public_ip`, and `ssh_connection_string`.

### Access the Web Server
Verify Nginx is running by navigating to the public IP in your browser:
```bash
http://<public_ip>
```
*(You should see the default Nginx welcome page!)*

### SSH into the Instance
Terraform securely generates a local `.pem` key for you. Make sure the file permissions are restricted, then use the provided output string to connect:

```bash
# Secure the private key
chmod 400 vpc-ec2-web-server-keyPair.pem

# Connect using the generated output string
ssh -i vpc-ec2-web-server-keyPair.pem ec2-user@<public_ip>
```

---

## 🧹 Clean Up

To prevent ongoing AWS charges, ensure you destroy the infrastructure when you are finished:

```bash
terraform destroy
```
*(Type `yes` when prompted to remove all resources cleanly.)*

---

## 📂 Project Structure

| File | Purpose |
| :--- | :--- |
| `main.tf` | Core infrastructure definitions (VPC, Subnets, EC2, Keys, SG). |
| `variables.tf` | Input definitions for modularity and reuse. |
| `outputs.tf` | Exports the required endpoints (IP, SSH command). |
| `provider.tf` | AWS Provider configuration and version constraints. |
| `terraform.tfvars`| User-defined value assignments for variables. |
| `.gitignore` | Security best practices (ignores state files, tfvars, and keys). |

---

<div align="center">
  <i>Built with ❤️ using Terraform and AWS</i>
</div>
