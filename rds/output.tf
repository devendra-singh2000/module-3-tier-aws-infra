output "RDS_ENDPOINT" {
    value = aws_db_instance.rds-instance.endpoint
}
output "RDS_USERNAME" {
    value = aws_db_instance.rds-instance.username
}
output "RDS_PASS" {
    value = aws_db_instance.rds-instance.password
    sensitive = true
}