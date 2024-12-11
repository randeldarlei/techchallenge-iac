data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    hostname     = "app.terraform.io"
    organization = "ACG-Terraform-Labs-Teste"
    workspaces = {
      name = "lab-migrate-state"
    }
  }
}

output "vpc_id" {
  value = data.terraform_remote_state.network.private_subnet_ids
}
