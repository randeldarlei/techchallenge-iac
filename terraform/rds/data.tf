data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "/home/darlei/Documents/tfstate/network/terraform.tfstate"
  }
}