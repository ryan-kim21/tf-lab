resource "aws_eks_cluster" "dev-eks-cluster" {

  depends_on = [
    aws_iam_role_policy_attachment.dev-iam-policy-eks-cluster,
    aws_iam_role_policy_attachment.dev-iam-policy-eks-cluster-vpc,
  ]

  name     = var.cluster-name
  role_arn = aws_iam_role.dev-iam-role-eks-cluster.arn
  version = "1.25"

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    security_group_ids = [aws_security_group.dev-sg-eks-cluster.id]
    subnet_ids         = [aws_subnet.dev-private-eks-subnet1.id, aws_subnet.dev-private-eks-subnet2.id]
    endpoint_public_access = false //?
    endpoint_private_access = true
  }


}