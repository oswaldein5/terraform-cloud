#* Block terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.47.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.6.1"
    }
  }
  required_version = "~>1.8.2"
}

#* Block provider
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = var.tags
  }
}