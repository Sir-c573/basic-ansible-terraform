output "public_ip" {
  description = "Public IP of EC2 insatance"
  value       = aws_instance.web.public_ip
}

output "insatance_id" {
  value = aws_instance.web.id
}