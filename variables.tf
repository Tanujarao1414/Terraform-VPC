variable "aws_region" {
  description = "Region for the VPC"
  default = "us-east-1"
}

variable "AWS_ACCESS_KEY" {
  description = "Access key"
}

variable "SECRET_KEY" {
  description = "Secret Access Key"
}


variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  default = "10.0.2.0/24"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default = "ami-09d95fab7fff3776c"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "public_key"
}