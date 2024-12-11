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

output "private_subnet_ids" {
  value       = data.terraform_remote_state.network.outputs.private_subnet_ids
}
