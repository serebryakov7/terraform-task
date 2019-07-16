resource "aws_eks_cluster" "simple" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks-master.arn

  vpc_config {
    security_group_ids = [aws_security_group.eks-master.id]
    subnet_ids         = var.cluster_subnet_ids
  }

  depends_on = [
    "aws_iam_role_policy_attachment.cluster-EKSClusterPolicy",
    "aws_iam_role_policy_attachment.cluster-EKSServicePolicy",
  ]
}