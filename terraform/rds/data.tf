data "terraform_remote_state" "networking" {
  backend = "local"
  config = {
    path = "/home/darlei/Documents/tfstate/network/terraform.tfstate"
  }
}