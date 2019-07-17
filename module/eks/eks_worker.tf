data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.simple.version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon distribution EKS AMI Account ID
}

locals {
  eks-node-userdata = <<-USERDATAEOF
    #!/bin/bash
    set -o xtrace
    /etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.simple.endpoint}' --b64-cluster-ca '${aws_eks_cluster.simple.certificate_authority.0.data}' '${var.cluster_name}'
  USERDATAEOF
}

resource "aws_launch_configuration" "eks" {
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.node.name
  image_id = data.aws_ami.eks-worker.id
  instance_type = "t2.micro"
  name_prefix = "eks"
  security_groups = [aws_security_group.eks-node.id]
  user_data_base64 = base64encode(local.eks-node-userdata)
  key_name = aws_key_pair.generated_key.key_name

  lifecycle {
    create_before_destroy = true
  }


}

resource "aws_autoscaling_group" "eks" {
  desired_capacity = 2
  launch_configuration = aws_launch_configuration.eks.id
  max_size = 3
  min_size = 1
  name = "eks"
  vpc_zone_identifier = var.cluster_subnet_ids
}
