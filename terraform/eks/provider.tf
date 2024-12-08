terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "ACG-Terraform-Labs-Teste"

    workspaces {
      name = "techchallenge-cluster"
    }
  }


#     backend "local" {
#     path = "/home/darlei/Documents/tfstate/eks/terraform.tfstate"
#   }
# }
}

provider "aws" {
  region     = "us-east-1"
  access_key = 
  secret_key =
}
