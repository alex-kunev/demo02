terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

    backend "s3" {
    bucket = "alexk-terraform-state1"
    key    = "key/tf.tfstate"
    region = "eu-central-1"
  }
}

provider "aws" {
  region = "eu-central-1"
}

# MODULES:
module "ec2_app" {
  source = "./ec2"

}

module "vpc_1" {
  source = "./vpc"
}

# VARIABLES: 
variable "infra_env" {
  type        = string
  description = "infrastructure environment"
}

variable "instance_size" {
  type        = string
  description = "Instance size"
  default     = "t2.micro"
}

variable "default_region" {
  type        = string
  description = "the region this infrastructure is in"
  default     = "us-east-2"
}