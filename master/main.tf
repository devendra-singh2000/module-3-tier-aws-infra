data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "myKey"       # Create a "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./myKey.pem"
  }
}

module "vpc" {
  source         = "../vpc/"
  vpc_cidr_block = var.vpc_cidr_block
}

module "security" {
  depends_on = [     module.vpc
  ]
  source = "../security/"
  #vpcid = module.vpc.Vpcid
  VPC_ID = module.vpc.Vpcid
}

module "ssm" {
  source = "../ssm/"
  ELB_DNS = module.elb.ELB_DNS
  ELB_DNS_APPLICATION = module.elb.ELB_DNS_APPLICATION
}

module "subnet" {
  source         = "../subnet/"
  vpc_cidr_block = var.vpc_cidr_block
  vpcid = module.vpc.Vpcid
  security_groups_presentation = [module.security.EC2_SG]
  ASG_AMI              = data.aws_ami.ubuntu.id               //PRECONFIGURED AMI FOR NGINX UBUNTU
  security_groups_application = [module.security.EC2_SG_APPLICATION]
}

module "rds" {
  source = "../rds/"
  //depends_on = [
  //  module.elb
  //]
  RDS_IDENTIFIER              = var.RDS_IDENTIFIER              //RDS IDENTIFIER
  RDS_DB_NAME                 = var.RDS_DB_NAME                 //DB INSTANCE INITIAL DATABASE
  RDS_STORAGE_TYPE            = var.RDS_STORAGE_TYPE            //STORAGE TYPE - 
  RDS_INSTANCE_CLASS          = var.RDS_INSTANCE_CLASS          //INSTANCE CLASS
  RDS_ENGINE                  = var.RDS_ENGINE                  //ENGINE NAME
  RDS_ENGINE_VERSION          = var.RDS_ENGINE_VERSION          //ENGINE VERSION
  RDS_BACKUP_RETENTION_PERIOD = var.RDS_BACKUP_RETENTION_PERIOD //RETENTION PERIOD FOR BACKUP
  RDS_USERNAME                = var.RDS_USERNAME                //RDS USERNAME
  RDS_PASSWORD                = var.RDS_PASSWORD                // RDS PASSWORD
  RDS_ALLOCATED_STORAGE       = var.RDS_ALLOCATED_STORAGE       //ALLOCATED STORAGE
  RDS_MULTIAZ                 = var.RDS_MULTIAZ                 // MULTI AZ - RDS

  RDS_SG             = [module.security.RDS_SG]
  PRIVATE_SUBNET_GRP = [module.subnet.PRIVATE_DATABASE_ID_1, module.subnet.PRIVATE_DATABASE_ID_2]
}

module "elb" {

  source           = "../ELB/"
  ELB_NAME         = var.ELB_NAME                                                   //LOAD BALANCER NAME
  ELB_NAME_APPLICATION = var.ELB_NAME_APPLICATION
  LB_TYPE          = var.LB_TYPE                                                    //LOAD BALACER TYPE
  PUBLIC_SUBNET_ID = [module.subnet.PUBLIC_SUBNET_ID_1, module.subnet.PUBLIC_SUBNET_ID_2] // ASSOCIATED PUBLIC SUBNET
  PRIVATE_SUBNET_ID = [module.subnet.PRIVATE_SUBNET_ID_1,module.subnet.PRIVATE_SUBNET_ID_2]
  SG               = [module.security.ELB_SG]                                       //SECURITY GROUP FOR LOAD BALANCER
  SG_APPLICATION = [module.security.ELB_SG_APPLICATION]
  TG_VPC           = module.vpc.Vpcid                                              // ASSOCIATED VPC FOR  LOAD BALANCER
}

module "asg" {
  source = "../asg/"
  depends_on = [
    module.elb
  ]
  VPC_ZONE             = [module.subnet.PUBLIC_SUBNET_ID_1, module.subnet.PUBLIC_SUBNET_ID_2] //VPC PUBLIC SUBNET TO BE ASSOCIATED IN ASG FOR HA
  VPC_ZONE_APPLICATION = [module.subnet.PRIVATE_SUBNET_ID_1,module.subnet.PRIVATE_SUBNET_ID_2]
  # ASG_AMI              = data.aws_ami.ubuntu.id               //PRECONFIGURED AMI FOR NGINX UBUNTU
  #ASG_INSTANCE_TYPE    = var.ASG_INSTANCE_TYPE       //INSTANCE TYPE EC2 T3A.SMALL
  ASG_MAX_INSTANCE     = var.ASG_MAX_INSTANCE          //MAXIMUM INSTANCES VIA ASG
  ASG_MIN_INSTANCE     = var.ASG_MIN_INSTANCE             //MINIMUM INSTANCES VIA ASG
  ASG_DESIRED_CAPACITY = var.ASG_DESIRED_CAPACITY            //DESIRED CAPACITY OF INSTANCES
  KEY_NAME             = "myKey"
  presentation_tier_template = module.subnet.presentation_tier
  application_tier_template = module.subnet.application_tier
  TG_ARN_APPLICATION = module.elb.TG_ARN_APPLICATION
  EC2_SG     = [module.security.EC2_SG] //SECURITY GROUP FOR INSTANCES VIA ASG
  TG_ARN = module.elb.TG_ARN      //ASSOCIATION OF TARGET GROUP 
#  ASG_USER_DATA_WPSTP = var.ASG_USER_DATA_WPSTP //SCRIPT TO BE USED FOR CONFIGURING WORDPRESS VIA LAUNCH CONFIG
}
