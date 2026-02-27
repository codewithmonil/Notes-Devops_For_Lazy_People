output "instance_ids" {
  description = "IDs of created EC2 instances"
  value       = [for inst in module.ec2_instance : inst.id]
}

output "public_ips" {
  description = "Public IPs of created EC2 instances"
  value       = [for inst in module.ec2_instance : inst.public_ip]
}

output "private_ips" {
  description = "Private IPs of created EC2 instances"
  value       = [for inst in module.ec2_instance : inst.private_ip]
}
