output "instance_name" {
  description = "Name of the Cloud SQL instance"
  value       = google_sql_database_instance.postgres.name
}

output "instance_connection_name" {
  description = "Connection name of the Cloud SQL instance"
  value       = google_sql_database_instance.postgres.connection_name
}

output "instance_self_link" {
  description = "Self link of the Cloud SQL instance"
  value       = google_sql_database_instance.postgres.self_link
}

output "database_name" {
  description = "Name of the database"
  value       = google_sql_database.database.name
}

output "user_name" {
  description = "Database user name"
  value       = google_sql_user.database_user.name
}

output "instance_ip_address" {
  description = "IP address of the Cloud SQL instance"
  value       = google_sql_database_instance.postgres.ip_address
}

output "instance_public_ip_address" {
  description = "Public IP address of the Cloud SQL instance"
  value       = google_sql_database_instance.postgres.public_ip_address
}

output "instance_private_ip_address" {
  description = "Private IP address of the Cloud SQL instance" 
  value       = google_sql_database_instance.postgres.private_ip_address
}
