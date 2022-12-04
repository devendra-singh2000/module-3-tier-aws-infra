# Deploying the full three-tier application 

## Requirements
| Name  | Version |
| ------ | ------ |
| Terraform | >=4.0 |
| AWS | >=4.0 |
| Ubuntu | >=20.04 |


##  Infrastructure Setup 
| Number | Name |
| ------ | ------|
| 1 | VPC |
| 2 | Public subnets |
| 2 | Private subnets |
| 2 | Autoscaling groups |
| 5 | Security Groups |
| 2 | Load Balancers (one private, one public) |
| 2 | Private EC2 instances (representing our application tier) |
|2 | Public EC2 instances (representing our presentation tier) |
| 1 | Nat Gateways (so private instances can connect to the internet) |
| 1 | Elastic IP addresses |
| 2 | rds instance |

#  Our Application 
Our application consists of 3 tiers 
 -  presentation tier (this represents normally the customer facing part of the application, so what the customer interacts with)
 -  Application tier (this is where we have our business logics)

 -  To keep it simple, our presentation tier simply forward requests to the business tier, that in turn run sql queries on the rds instance.
## Providers
AWS


## Modules
| Name | Description |
| ------ | ------ |
| vpc | To create VPC for our infrastructure |
| asg | To Create auto scaling |
| elb | For load balancer|
| rds | For database creation |
| sg | Security groups |
| subnet | For creating subnet igw nat eip|
| ssm | Parameter store|


##   Resources 
| Name | Type |
|------|------|
| [aws_vpc](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_autoscaling_group](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_autoscaling_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mq_broker) | resource |
| [aws_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source || [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_lb_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_lb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_db_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | resource |
| [aws_ssm_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_db_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_db_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [tls_private_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_key_pair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_launch_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |

## Outputs
| Name | Description |
|------|-------------|
| Load  balancer DNS | `NA` |
| Instance ID | `NA` |






##  Deploying the infrastructure + application 
First initialise the backend, and install the aws plugin and prepare terraform.:

```sh
terraform init
```

The terraform plan command evaluates a Terraform configuration to determine the desired state of all the resources it declares:

```sh
terraform plan
```
The terraform apply command executes the actions proposed in a terraform plan
```sh
terraform apply
```

The terraform destroy command terminates resources managed by our Terraform project.
```sh
terraform destroy
```


## Author
----
Module managed by [Devendra Singh](https://github.com/devendra-singh2000)
