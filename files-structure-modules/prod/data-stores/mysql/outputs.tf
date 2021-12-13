output "address" {
  value       = aws_db_instance.example.address
  description = "Connect to the database at this endpoint"
}

output "port" {
  value       = aws_db_instance.example.port
  description = "The port the database is listening on"
}

# output "rds_password" {
#   value = aws_db_instance.example.password
#   description = "The RDS password"
# }