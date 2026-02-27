variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Prefix used for naming resources"
  type        = string
  default     = "ec2-module-demo"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}

variable "instance_count" {
  description = "How many EC2 instances to create"
  type        = number
  default     = 3
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing EC2 key pair name for SSH access"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where security group will be created"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where all EC2 instances will be launched"
  type        = string
}

variable "allowed_ssh_cidrs" {
  description = "CIDR blocks allowed to SSH to the instances"
  type        = list(string)
}

variable "root_volume_size_gb" {
  description = "Root volume size in GiB"
  type        = number
  default     = 8
}
