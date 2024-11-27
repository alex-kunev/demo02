# Terraform AWS Security deployment
This app features AWS EC2 and VPC resources, configured using Terraform modules, to create a secure deployment

## Terraform configuration
Modules:

- EC2 Module: The ec2_app module is sourced from the ec2 directory. This module likely defines the configuration for EC2 instances.
    - EC2 Instance: Provisions an EC2 instance using the AMI ID retrieved from the data source and the instance size specified by the instance_size variable. The instance is tagged with the name "Web01".
    - Elastic IP (EIP): Provisions an Elastic IP and tags it with the infrastructure name and project name specified by the infra_name and project variables, respectively.
    - EIP Association: Associates the Elastic IP with the EC2 instance if the create_eip variable is set to true.

- VPC Module: The vpc_1 module is sourced from the vpc directory. This module likely defines the configuration for a Virtual Private Cloud (VPC).
    - VPC: Provisions an AWS VPC with a specified CIDR block. The VPC is tagged with the infrastructure name and project name specified by the infra_name and project variables.
    - Public Subnets: Provisions multiple public subnets within the VPC. Each subnet is created in a specific availability zone and uses a subset of the VPC's CIDR block. The subnets are tagged with the public name, project name, and a unique identifier based on the availability zone and subnet number.
    - Private Subnets: Provisions multiple private subnets within the VPC. Each subnet is created in a specific availability zone and uses a subset of the VPC's CIDR block. The subnets are tagged with the private name, project name, and a unique identifier based on the availability zone and subnet number.

Variables:

- infra_env: A string variable that describes the infrastructure environment.
- instance_size: A string variable that specifies the instance size, with a default value of t2.micro.
- default_region: A string variable that specifies the default region for the infrastructure, with a default value of us-east-2.
