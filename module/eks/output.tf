output "eks_kubeconfig" {
  value = "${ local.kubeconfig }"
  depends_on = [
    "aws_eks_cluster.simple"
  ]
}

output "target_group_arn" {
  value = "${ aws_lb_target_group.eks.arn }"
}

output "node_sg_id" {
  value = "${ aws_security_group.eks-node.id }"
}

output "config_map_aws_auth" {
  value = "${ local.config_map_aws_auth }"
}