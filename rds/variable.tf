# RDS variables
variable "RDS_DB_NAME" {}
variable "RDS_INSTANCE_CLASS" {}
variable "RDS_ENGINE" {}
variable "RDS_ENGINE_VERSION" {}
variable "RDS_BACKUP_RETENTION_PERIOD" {}
variable "RDS_USERNAME" {}
variable "RDS_PASSWORD" {}
variable "RDS_ALLOCATED_STORAGE" {}
variable "RDS_IDENTIFIER" {}
variable "RDS_MULTIAZ" {}
variable "RDS_STORAGE_TYPE" {}
variable "RDS_SG" {}
variable "PRIVATE_SUBNET_GRP" {
    type = list(string)
}
variable "RDS_ENGINE_PARAMETER_GROUP_FAMILY" {
    description = "Parameter group mysql5.7"
    default = "mysql5.7"
}
variable "RDS_PUBLICLY_ACCESSIBLE" {
    description = "accessibility for rds"
    default = "false"
}