resource "aws_eks_cluster" "techchalenge_cluster" {
  name     = "techchalenge-eks-cluster"
  role_arn = aws_iam_role.cluster_role.id

  vpc_config {
    subnet_ids = [
      aws_subnet.private_subnet.id,
      aws_subnet.public_subnet.id
    ]
  }

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
