variable "instance_count" {
  description = "Number of EC2 instances to deploy"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.instance_type)
    error_message = "Valid values for instance_type are: t2.micro, t3.micro. This ensures free tier eligibility."
  }
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the instance will be launched"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to attach to the instance"
  type        = string
}