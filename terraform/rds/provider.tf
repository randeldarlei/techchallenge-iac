terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

      backend "local" {
    path = "/home/darlei/Documents/tfstate/rds/terraform.tfstate"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "dev"
}