resource "tls_private_key" "cluster_rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "eks_access"
  public_key = tls_private_key.cluster_rsa.public_key_openssh
}