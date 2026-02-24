# VPC and EC2 Web Server Foundation

This project sets up a foundational AWS infrastructure using Terraform. It provisions a custom Virtual Private Cloud (VPC), public and private subnets across multiple Availability Zones, and an EC2 instance running an Nginx web server. The infrastructure is primarily configured through standard variables for custom CIDR blocks and instances.

## Architecture

This project creates the following AWS resources:
- 1 VPC
- 2 Public Subnets (one per AZ)
- 2 Private Subnets (one per AZ)
- 1 Internet Gateway
- 1 Route Table for the public subnets
- 2 Route Table Associations
- 1 Security Group (Allows SSH, HTTP/HTTPS inbound; allows all outbound)
- 1 EC2 Instance (Amazon Linux 2023) running Nginx
- 1 Elastic IP assigned to the EC2 instance
- Dynamically generated SSH Key Pair (RSA 4096) mapped to the EC2 instance

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed (~> 6.0).
- An AWS account with your credentials configured locally (e.g., via `aws configure` or environment variables).

## Project Structure

```text
├── main.tf             # Core resource definitions (VPC, Subnets, EC2, Key Pair, Security Group)
├── variables.tf        # Variable declarations (CIDRs, region, etc.)
├── outputs.tf          # Output definitions (VPC ID, Public IP, SSH connection string)
├── provider.tf         # AWS Provider configuration
├── terraform.tfvars    # User-provided values for variables
└── .gitignore          # Ignored files, including sensitive state and private keys
```

## Quick Start Guide

### 1. Configure the Variables
Locate the `terraform.tfvars` file and modify the values as needed. Make sure you set a valid `ami_id` for your target `aws_region`.
```hcl
aws_region           = "us-east-1"
instance_type        = "t2.small"
ami_id               = "ami-0f3caa1cf4417e51b" # Amazon Linux 2023 in us-east-1
key_name             = "vpc-ec2-web-server-keyPair"
```

### 2. Initialize Terraform
Run initialization to download the necessary AWS, local, and TLS providers.
```bash
terraform init
```

### 3. Review the Execution Plan
Always validate and preview your changes before applying them. 
```bash
terraform validate
terraform plan
```

### 4. Apply the Configuration
Deploy the infrastructure to your AWS account. Terraform will prompt you to type `yes` before proceeding.
```bash
terraform apply
```

### 5. Access the Web Server
Once the deployment finishes, Terraform will output your new SSH connection string and the public IP.
- **View Nginx:** Open your browser and navigate to `http://<public_ip>`.
- **SSH into the instance:** Due to the TLS key-pair generation, Terraform automatically creates the private key locally. Make sure your key has the right permissions and use the SSH string from `terraform output`:
  ```bash
  chmod 400 <key_name>.pem
  ssh -i <key_name>.pem ec2-user@<public_ip>
  ```

### 6. Clean Up
To remove all AWS resources created by this project and avoid incurring further charges:
```bash
terraform destroy
```

## Important Version Control Notice:
Your `terraform.tfvars` file might contain sensitive items. Similarly, your generated `.pem` keys, `.terraform` folder, and `.tfstate` files **should never be submitted to version control**. This repository includes a `.gitignore` that handles these exclusions automatically.
