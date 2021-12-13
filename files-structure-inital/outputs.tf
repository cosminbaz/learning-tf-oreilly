output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP address of the web server"
}

output "private_ip" {
  value       = aws_instance.example.private_ip
  description = "The private IP address of the web server"
}
