terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "compute" {
  source = "./modules/compute"
}

module "networking" {
  source = "./modules/networking"
}

module "security" {
  source = "./modules/security"
}