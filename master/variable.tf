variable "vpc_cidr_block" {
  
}

# RDS variables
variable "RDS_DB_NAME" {}
variable "RDS_INSTANCE_CLASS" {}
variable "RDS_ENGINE" {}
variable "RDS_ENGINE_VERSION" {}
variable "RDS_BACKUP_RETENTION_PERIOD" {}
variable "RDS_PUBLICLY_ACCESSIBLE" {} //
variable "RDS_USERNAME" {}
variable "RDS_PASSWORD" {}
variable "RDS_ALLOCATED_STORAGE" {}
variable "RDS_ENGINE_PARAMETER_GROUP_FAMILY" {} //
variable "RDS_IDENTIFIER" {}
variable "RDS_MULTIAZ" {}
variable "RDS_STORAGE_TYPE" {}

# ELB variables
variable "ELB_NAME" {}
variable "LB_TYPE" {}
variable "ELB_NAME_APPLICATION" {
  
}

# Web variables
#variable "ASG_AMI" {}
variable "ASG_INSTANCE_TYPE" {}
variable "ASG_MIN_INSTANCE" {}
variable "ASG_MAX_INSTANCE" {}
variable "ASG_DESIRED_CAPACITY" {}

#variable "KEY_NAME" {}
