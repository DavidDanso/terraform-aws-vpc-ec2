<div align="center">
  <h1>🚀 AWS Modular Infrastructure: VPC & EC2 Deployment</h1>
  <p><i>A scalable, reusable Infrastructure-as-Code foundation demonstrating Terraform modules and AWS networking expertise.</i></p>

  <!-- Badges -->
  <img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform" />
  <img src="https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white" alt="AWS" />
  <img src="https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white" alt="Nginx" />
</div>

<br />

## 📋 Overview

This project provisions a secure, custom AWS Virtual Private Cloud (VPC) and automates EC2 compute deployments using **HashiCorp Terraform**. It has been specifically designed using a **modular architecture** to maximize reusability, maintainability, and scalability.

### Why This Project Matters
This repository serves as an advanced demonstration of **Infrastructure-as-Code (IaC)** principles. It proves a practical understanding of:
- **Module Composition:** Encapsulating logic into independent `networking`, `security`, and `compute` modules with strict input/output boundaries.
- **Resource Scaling:** Using Terraform's `count` meta-argument to dynamically scale the number of compute instances deployed (e.g., 1 for Dev, 3 for Prod).
- **Variable Validation:** Enforcing infrastructure compliance natively within Terraform to ensure deployed instances stay within the AWS Free Tier.
- **AWS Networking:** Configuring VPCs, subnets, Internet Gateways, Route Tables, and Security Groups seamlessly.

---

## 🏗️ Modular Architecture

The infrastructure is broken down into three independent, reusable modules:

1. **`networking` Module:**
   - Creates a **Custom VPC** with a configurable CIDR block.
   - Deploys **4 Subnets** across 2 Availability Zones (2 Public, 2 Private).
   - Manages the **Internet Gateway** and **Route Tables**.
   
2. **`security` Module:**
   - Deploys **Security Groups** restricting ingress strictly to HTTP/HTTPS (`80`, `443`) and SSH (`22`), isolating it from the network deployment.

3. **`compute` Module:**
   - Deploys variable counts of **EC2 Web Servers** running Amazon Linux 2023.
   - Bootstraps servers automatically with Nginx.
   - Generates **Dynamic TLS Key Pairs** for secure, automated SSH access.
   - Attaches and maps **Elastic IPs (EIP)** to the running instances.

---

## 🚀 Quick Start Guide

### Prerequisites

* [Terraform](https://developer.hashicorp.com/terraform/downloads) CLI (`~> 6.0`)
* AWS CLI installed and configured (`aws configure`) with valid credentials.

### 1. Clone & Configure

```bash
git clone https://github.com/DavidDanso/terraform-aws-vpc-ec2.git
cd terraform-aws-vpc-ec2
```

Open `terraform.tfvars` in the root directory to customize your deployment. Notice you can scale the architecture using `instance_count`:

```hcl
aws_region           = "us-east-1"
instance_count       = 1            # Easily scale your footprint!
instance_type        = "t2.micro"   # Strict validation ensures free tier usage
ami_id               = "ami-0f3caa1cf4417e51b" # Ensure this matches your region!
key_name             = "vpc-ec2-web-server-keyPair"
```

### 2. Initialize Terraform
Downloads the required modules, AWS, TLS, and Local providers.
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

Once `terraform apply` completes successfully, the root module will loop through the deployed instances and output lists of `public_dns`, `public_ips`, and `ssh_connection_strings`.

### Access the Web Server
Verify Nginx is running by navigating to a public IP in your browser:
```bash
http://<public_ip>
```
*(You should see the default Nginx welcome page!)*

### SSH into the Instances
Terraform securely generates a local `.pem` key for you. Make sure the file permissions are restricted, then use the provided output string to connect:

```bash
# Secure the private key
chmod 400 vpc-ec2-web-server-keyPair.pem

# Connect using the generated output string
ssh -i vpc-ec2-web-server-keyPair.pem ec2-user@<public_ip>
```

---

## 🧹 Clean Up

To prevent ongoing AWS charges, ensure you destroy the master infrastructure when you are finished:

```bash
terraform destroy
```

---

## 📂 Project Structure

| Path/File | Purpose |
| :--- | :--- |
| **`modules/`** | **Directory containing all encapsulated modules** |
| `modules/networking/` | Provisions VPC, Subnets, IGW, and Route Tables. |
| `modules/security/` | Provisions Security Groups. Requires VPC ID input. |
| `modules/compute/` | Provisions EC2, EIPs, and SSH Keys. Validates inputs. |
| **`Root Environment`** | **The main configuration uniting the modules** |
| `main.tf` | Instantiates and wires the modules together. |
| `variables.tf` | Root definitions for input logic. |
| `outputs.tf` | Consolidates and exports module endpoints. |
| `terraform.tfvars`| User-defined value assignments for deployment. |
| `.gitignore` | Security best practices (ignores state files, tfvars, and keys). |

---

<div align="center">
  <i>Built with ❤️ using Terraform and AWS</i>
</div>
