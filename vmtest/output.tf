output "public_ip_address" {
  value       = aws_instance.vm.public_ip
  description = "Ec2 Public IP address."
}

output "instance_id" {
  value = aws_instance.vm.id
  description = "Instance ID of the created EC2."
}