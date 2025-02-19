terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.85.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
  default_tags {
    tags = {
      Project = "abz-test-assignment"
    }
  }
}