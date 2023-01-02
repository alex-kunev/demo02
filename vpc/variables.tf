variable "infra_name" {
  type = string
  description = "Name"
  default = "VPC01"
}

variable "project" {
  type = string
  description = "Project name"
  default = "Demo02"
}

variable "public_name" {
  type = string
  description = "Name"
  default = "Subnet-public"
}

variable "private_name" {
  type = string
  description = "Name"
  default = "Subnet-private"
}

variable "public_subnet_numbers" {
  type = map(number)

  description = "Map of AZ to a number that should be used for public subnets"

  default = {
    "us-east-2a" = 1
    "us-east-2b" = 2
    "us-east-2c" = 3
  }
}

variable "private_subnet_numbers" {
  type = map(number)

  description = "Map of AZ to a number that should be used for private subnets"

  default = {
    "us-east-2a" = 4
    "us-east-2b" = 5
    "us-east-2c" = 6
  }
}

variable "vpc_cidr" {
  type        = string
  description = "The IP range to use for the VPC"
  default     = "10.0.0.0/16"
}

variable "infra_env" {
  type        = string
  description = "infrastructure environment"
  default     = "env01"
}

variable subnets {
  type = list(string)
  description = "valid subnets to assign to server"
  default     = ["subnet01", "subnet02"]
}
 
variable security_groups {
  type = list(string)
  description = "security groups to assign to server"
  default = []
}