resource "aws_eks_cluster" "techchalenge_cluster" {
  name     = "techchalenge-eks-cluster"
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController
  ]
}

output "endpoint" {
  value = aws_eks_cluster.techchalenge_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.techchalenge_cluster.certificate_authority[0].data
}

resource "aws_eks_node_group" "techchallenge_node_group" {
  cluster_name    = aws_eks_cluster.techchalenge_cluster.name
  node_group_name = "techchallenge-node-group"
  node_role_arn   = aws_iam_role.node_group_role.arn

  scaling_config {
    desired_size = 1
    max_size     = 10
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
}
