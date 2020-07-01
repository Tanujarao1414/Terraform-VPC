# Define AWS as our provider
provider "aws" {
  region = var.aws_region
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.SECRET_KEY}"
}