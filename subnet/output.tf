output "PUBLIC_SUBNET_ID_1" {
    value = aws_subnet.main-public-1.id  
}
output "PUBLIC_SUBNET_ID_2" {
    value = aws_subnet.main-public-2.id  
}
output "PRIVATE_SUBNET_ID_1" {
    value = aws_subnet.main-private-1.id
}
output "PRIVATE_SUBNET_ID_2" {
    value = aws_subnet.main-private-2.id
}
output "PRIVATE_DATABASE_ID_1" {
    value = aws_subnet.database-private-1.id
}
output "PRIVATE_DATABASE_ID_2" {
    value = aws_subnet.database-private-2.id
}
output "presentation_tier" {
    value = aws_launch_template.presentation_tier.id
}
output "application_tier" {
    value = aws_launch_template.application_tier.id
}   