variable "infra_name" {
  type = string
  description = "Name"
  default = "Web01"
}

variable "project" {
  type = string
  description = "Project name"
  default = "Demo02"
}

variable "instance_size" {
  type        = string
  description = "ec2 web server size"
  default     = "t2.micro"
}

variable "instance_ami" {
  type        = string
  description = "Server image to use"
  default = "ami-0b0dcb5067f052a63"
}

variable "create_eip" {
  type = bool
  description = "whether or create an EIP for the ec2 instance or not"
  default = false
}