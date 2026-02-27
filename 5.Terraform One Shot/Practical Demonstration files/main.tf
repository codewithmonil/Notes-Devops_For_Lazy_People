terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}



resource "aws_security_group" "ec2" {
  name        = "${var.project_name}-sg"
  description = "Security group for EC2 instances created via terraform-aws-modules/ec2-instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  count = var.instance_count

  name                   = "${var.project_name}-${count.index + 1}"
  ami                    = "ami-051a31ab2f4d498f5"
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2.id]

  root_block_device = [{
    encrypted   = true
    volume_type = "gp3"
    volume_size = var.root_volume_size_gb
  }]

  tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}
