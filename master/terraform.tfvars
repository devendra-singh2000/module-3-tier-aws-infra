vpc_cidr_block = "10.0.0.0/16"

# RDS variable
RDS_DB_NAME                       = "java"
RDS_STORAGE_TYPE                  = "gp2"
RDS_INSTANCE_CLASS                = "db.t3.micro"
RDS_ENGINE                        = "mysql"
RDS_ENGINE_VERSION                = "5.7"
RDS_BACKUP_RETENTION_PERIOD       = "0"
RDS_PUBLICLY_ACCESSIBLE           = "true" //
RDS_USERNAME                      = "test"
RDS_PASSWORD                      = "test123$%"
RDS_ALLOCATED_STORAGE             = "8"
RDS_ENGINE_PARAMETER_GROUP_FAMILY = "mysql5.7" //
RDS_IDENTIFIER                    = "java-db"
RDS_MULTIAZ                       = "true"

# ELB variables
ELB_NAME = "java-elb"
ELB_NAME_APPLICATION = "application-elb"
LB_TYPE  = "application"

# EC2/Launch Configuration variables
#ASG_AMI                 = "ami-0b20e794e4ae84125" //ubuntu 20.04 nginx configured - efs 
ASG_INSTANCE_TYPE       = "t3a.small"
ASG_MIN_INSTANCE        = "1"
ASG_MAX_INSTANCE        = "5"
ASG_DESIRED_CAPACITY    = "2"
#KEY_NAME                = "myKey"
