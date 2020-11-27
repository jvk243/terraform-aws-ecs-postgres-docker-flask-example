output "postgres_endpoint" {
  value = aws_db_instance.rds_instance.endpoint
}

output "alb-dns-name" {
  value = aws_alb.alb.dns_name
}
