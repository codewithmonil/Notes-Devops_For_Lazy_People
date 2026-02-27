aws_region   = "ap-south-1"
project_name = "ec2-module-demo"
environment  = "dev"

instance_count = 3
instance_type  = "t3.micro"

# Replace with your existing EC2 key pair name in this region
key_name = "terraform-key-pair"

# Replace with your target VPC and subnet IDs
vpc_id    = "vpc-01302c07ac5f6877c"
subnet_id = "subnet-050ae9e4a9cefd6a5"

# Restrict SSH to your public IP/CIDR
allowed_ssh_cidrs = ["150.107.191.42/32"]

root_volume_size_gb = 8
