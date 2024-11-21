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
      name = "lab-migrate-state"
    }
  }

  # Caso queira alternar para backend local, remova o comentário das linhas abaixo:
  # backend "local" {
  #   path = "/home/darlei/Documents/tfstate/cognito/terraform.tfstate"
  # }
}

provider "aws" {
  region     = "us-east-1"
}
