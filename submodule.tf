module "network" {
    source = "./module/network"
    aws_avaliability_zones = var.aws_avaliability_zones
}

module "eks" {
  source = "./module/eks"
  accessing_computer_ip = var.accessing_computer_ip
  keypair_name = var.keypair_name
  cluster_name = var.cluster_name

  // Variable forwarding from network module 
  vpc_id                  = module.network.vpc_id
  cluster_subnet_ids          = module.network.cluster_subnet_ids
}