variable "project" {
  type    = string
  description = "The name of the project"
}
variable "region" {
  type    = string
  default = "us-east-1"
}
[ec2-user@ip-172-31-23-39 vmtest]$ cat provider.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.36.1"
    }
  }
}

provider "aws" {
  region  = var.region
}