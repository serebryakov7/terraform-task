output "eks_kubeconfig" {
  value = local.kubeconfig
  depends_on = [
    "aws_eks_cluster.simple"
  ]
}

output "node_sec_group_id" {
  value = aws_security_group.eks-node.id
}

output "config_map_aws_auth" {
  value = local.config_map_aws_auth
}

output "keypair" {
  value = aws_key_pair.generated_key
}
